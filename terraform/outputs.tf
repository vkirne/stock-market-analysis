# Terraform Outputs
# Stock Market Analytics Dashboard

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

# ECR Outputs
output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = module.ecr.repository_name
}

# ALB Outputs
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = module.alb.alb_zone_id
}

output "application_url" {
  description = "URL to access the application"
  value       = "http://${module.alb.alb_dns_name}"
}

# ECS Outputs
output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs.service_name
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.ecs.task_definition_arn
}

# CodePipeline Outputs
output "codepipeline_name" {
  description = "Name of the CodePipeline"
  value       = module.codepipeline.pipeline_name
}

output "codepipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = module.codepipeline.pipeline_arn
}

# CodeBuild Outputs
output "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  value       = module.codebuild.project_name
}

# CloudWatch Outputs
output "cloudwatch_log_group" {
  description = "Name of the CloudWatch log group for ECS"
  value       = module.ecs.log_group_name
}

# SNS Outputs
output "sns_topic_arn" {
  description = "ARN of the SNS topic for notifications"
  value       = module.codepipeline.sns_topic_arn
}

# Secrets Manager Outputs
output "api_key_secret_arn" {
  description = "ARN of the API key secret in Secrets Manager"
  value       = aws_secretsmanager_secret.api_key.arn
}

# Deployment Information
output "deployment_info" {
  description = "Deployment information and next steps"
  value = <<-EOT
    
    ========================================
    Deployment Complete!
    ========================================
    
    Application URL: http://${module.alb.alb_dns_name}
    
    ECS Cluster: ${module.ecs.cluster_name}
    ECS Service: ${module.ecs.service_name}
    
    CodePipeline: ${module.codepipeline.pipeline_name}
    CodeBuild Project: ${module.codebuild.project_name}
    
    ECR Repository: ${module.ecr.repository_url}
    
    Next Steps:
    1. Push code to GitHub ${var.github_branch} branch to trigger pipeline
    2. Monitor pipeline: aws codepipeline get-pipeline-state --name ${module.codepipeline.pipeline_name}
    3. View logs: aws logs tail /ecs/${local.name_prefix} --follow
    4. Access application at: http://${module.alb.alb_dns_name}
    
    ========================================
  EOT
}
