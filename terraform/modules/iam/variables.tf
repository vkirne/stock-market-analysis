# IAM Module Variables

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "secrets_arns" {
  description = "List of Secrets Manager secret ARNs that ECS tasks need access to"
  type        = list(string)
  default     = []
}

variable "artifacts_bucket_arn" {
  description = "ARN of the S3 bucket for pipeline artifacts"
  type        = string
}

variable "codebuild_project_arn" {
  description = "ARN of the CodeBuild project"
  type        = string
}

variable "enable_codedeploy" {
  description = "Enable CodeDeploy role for blue/green deployments"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
