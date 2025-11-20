# CodePipeline Module Variables

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "pipeline_name" {
  description = "Name of the CodePipeline"
  type        = string
}

variable "service_role_arn" {
  description = "ARN of the IAM role for CodePipeline"
  type        = string
}

# GitHub Configuration
variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch to deploy from"
  type        = string
  default     = "main"
}

variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}

# CodeBuild Configuration
variable "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  type        = string
}

# ECS Configuration
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

# Notification Configuration
variable "notification_email" {
  description = "Email address for pipeline notifications"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
