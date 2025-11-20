# CodePipeline Module
# Creates CodePipeline for CI/CD automation

# S3 Bucket for Pipeline Artifacts
resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.name_prefix}-pipeline-artifacts"

  tags = var.tags
}

# Enable versioning for artifacts bucket
resource "aws_s3_bucket_versioning" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable encryption for artifacts bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access to artifacts bucket
resource "aws_s3_bucket_public_access_block" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# SNS Topic for Pipeline Notifications
resource "aws_sns_topic" "pipeline" {
  name = "${var.name_prefix}-pipeline-notifications"

  tags = var.tags
}

# SNS Topic Subscription (if email provided)
resource "aws_sns_topic_subscription" "pipeline_email" {
  count = var.notification_email != "" ? 1 : 0

  topic_arn = aws_sns_topic.pipeline.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

# CodePipeline
resource "aws_codepipeline" "main" {
  name     = var.pipeline_name
  role_arn = var.service_role_arn

  artifact_store {
    location = aws_s3_bucket.artifacts.bucket
    type     = "S3"
  }

  # Source Stage - GitHub
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner      = var.github_owner
        Repo       = var.github_repo
        Branch     = var.github_branch
        OAuthToken = var.github_token
      }
    }
  }

  # Build Stage - CodeBuild
  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

  # Deploy Stage - ECS
  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ClusterName = var.ecs_cluster_name
        ServiceName = var.ecs_service_name
        FileName    = "imagedefinitions.json"
      }
    }
  }

  tags = var.tags
}

# CloudWatch Event Rule for Pipeline State Changes
resource "aws_cloudwatch_event_rule" "pipeline" {
  name        = "${var.name_prefix}-pipeline-state-change"
  description = "Capture pipeline state changes"

  event_pattern = jsonencode({
    source      = ["aws.codepipeline"]
    detail-type = ["CodePipeline Pipeline Execution State Change"]
    detail = {
      pipeline = [aws_codepipeline.main.name]
      state    = ["FAILED", "SUCCEEDED"]
    }
  })

  tags = var.tags
}

# CloudWatch Event Target - SNS
resource "aws_cloudwatch_event_target" "pipeline_sns" {
  rule      = aws_cloudwatch_event_rule.pipeline.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.pipeline.arn

  input_transformer {
    input_paths = {
      pipeline  = "$.detail.pipeline"
      state     = "$.detail.state"
      execution = "$.detail.execution-id"
    }
    input_template = "\"Pipeline <pipeline> execution <execution> has <state>.\""
  }
}

# SNS Topic Policy for CloudWatch Events
resource "aws_sns_topic_policy" "pipeline" {
  arn = aws_sns_topic.pipeline.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
        Action   = "SNS:Publish"
        Resource = aws_sns_topic.pipeline.arn
      }
    ]
  })
}
