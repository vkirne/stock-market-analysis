# CodeBuild Module
# Creates CodeBuild project for building Docker images

# CloudWatch Log Group for CodeBuild
resource "aws_cloudwatch_log_group" "codebuild" {
  name              = "/aws/codebuild/${var.project_name}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

# CodeBuild Project
resource "aws_codebuild_project" "main" {
  name          = var.project_name
  description   = "Build project for ${var.project_name}"
  service_role  = var.service_role_arn
  build_timeout = var.build_timeout

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type  = var.cache_type
    modes = var.cache_type == "LOCAL" ? ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"] : []
  }

  environment {
    compute_type                = var.compute_type
    image                       = var.image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true  # Required for Docker builds

    # Environment variables
    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = lookup(environment_variable.value, "type", "PLAINTEXT")
      }
    }

    # AWS Region
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }

    environment_variable {
      name  = "AWS_REGION"
      value = var.aws_region
    }

    # ECR Repository URL
    environment_variable {
      name  = "ECR_REGISTRY"
      value = var.ecr_registry_url
    }

    environment_variable {
      name  = "ECR_REPOSITORY"
      value = var.ecr_repository_name
    }

    # Image tag
    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.codebuild.name
      stream_name = "build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.buildspec_path
  }

  tags = var.tags
}
