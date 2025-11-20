# CodeBuild Module Variables

variable "project_name" {
  description = "Name of the CodeBuild project"
  type        = string
}

variable "service_role_arn" {
  description = "ARN of the IAM role for CodeBuild"
  type        = string
}

variable "compute_type" {
  description = "Compute type for CodeBuild"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"

  validation {
    condition = contains([
      "BUILD_GENERAL1_SMALL",
      "BUILD_GENERAL1_MEDIUM",
      "BUILD_GENERAL1_LARGE",
      "BUILD_GENERAL1_2XLARGE"
    ], var.compute_type)
    error_message = "Invalid compute type."
  }
}

variable "image" {
  description = "Docker image for CodeBuild"
  type        = string
  default     = "aws/codebuild/standard:7.0"
}

variable "build_timeout" {
  description = "Build timeout in minutes"
  type        = number
  default     = 60
}

variable "buildspec_path" {
  description = "Path to buildspec file in repository"
  type        = string
  default     = "buildspec.yml"
}

variable "cache_type" {
  description = "Cache type (LOCAL, S3, or NO_CACHE)"
  type        = string
  default     = "LOCAL"

  validation {
    condition     = contains(["LOCAL", "S3", "NO_CACHE"], var.cache_type)
    error_message = "Cache type must be LOCAL, S3, or NO_CACHE."
  }
}

variable "environment_variables" {
  description = "Additional environment variables for CodeBuild"
  type = list(object({
    name  = string
    value = string
    type  = optional(string)
  }))
  default = []
}

variable "ecr_registry_url" {
  description = "URL of the ECR registry"
  type        = string
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "log_retention_days" {
  description = "CloudWatch Logs retention in days"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
