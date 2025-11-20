# CodeBuild Module Outputs

output "project_id" {
  description = "ID of the CodeBuild project"
  value       = aws_codebuild_project.main.id
}

output "project_name" {
  description = "Name of the CodeBuild project"
  value       = aws_codebuild_project.main.name
}

output "project_arn" {
  description = "ARN of the CodeBuild project"
  value       = aws_codebuild_project.main.arn
}

output "log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.codebuild.name
}

output "log_group_arn" {
  description = "ARN of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.codebuild.arn
}
