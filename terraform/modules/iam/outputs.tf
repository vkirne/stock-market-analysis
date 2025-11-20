# IAM Module Outputs

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution.name
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = aws_iam_role.ecs_task.arn
}

output "ecs_task_role_name" {
  description = "Name of the ECS task role"
  value       = aws_iam_role.ecs_task.name
}

output "codebuild_role_arn" {
  description = "ARN of the CodeBuild service role"
  value       = aws_iam_role.codebuild.arn
}

output "codebuild_role_name" {
  description = "Name of the CodeBuild service role"
  value       = aws_iam_role.codebuild.name
}

output "codepipeline_role_arn" {
  description = "ARN of the CodePipeline service role"
  value       = aws_iam_role.codepipeline.arn
}

output "codepipeline_role_name" {
  description = "Name of the CodePipeline service role"
  value       = aws_iam_role.codepipeline.name
}

output "codedeploy_role_arn" {
  description = "ARN of the CodeDeploy service role (if enabled)"
  value       = var.enable_codedeploy ? aws_iam_role.codedeploy[0].arn : null
}

output "codedeploy_role_name" {
  description = "Name of the CodeDeploy service role (if enabled)"
  value       = var.enable_codedeploy ? aws_iam_role.codedeploy[0].name : null
}
