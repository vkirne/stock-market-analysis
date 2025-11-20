# CodePipeline Module Outputs

output "pipeline_id" {
  description = "ID of the CodePipeline"
  value       = aws_codepipeline.main.id
}

output "pipeline_name" {
  description = "Name of the CodePipeline"
  value       = aws_codepipeline.main.name
}

output "pipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = aws_codepipeline.main.arn
}

output "artifacts_bucket_id" {
  description = "ID of the S3 artifacts bucket"
  value       = aws_s3_bucket.artifacts.id
}

output "artifacts_bucket_arn" {
  description = "ARN of the S3 artifacts bucket"
  value       = aws_s3_bucket.artifacts.arn
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic for notifications"
  value       = aws_sns_topic.pipeline.arn
}

output "sns_topic_name" {
  description = "Name of the SNS topic for notifications"
  value       = aws_sns_topic.pipeline.name
}
