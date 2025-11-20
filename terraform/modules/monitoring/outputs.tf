# Monitoring Module Outputs

output "ecs_cpu_alarm_arn" {
  description = "ARN of the ECS CPU utilization alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_cpu_high.arn
}

output "ecs_memory_alarm_arn" {
  description = "ARN of the ECS memory utilization alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_memory_high.arn
}

output "ecs_task_count_alarm_arn" {
  description = "ARN of the ECS task count alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_task_count_low.arn
}

output "alb_unhealthy_targets_alarm_arn" {
  description = "ARN of the ALB unhealthy targets alarm"
  value       = aws_cloudwatch_metric_alarm.alb_unhealthy_targets.arn
}

output "alb_no_healthy_targets_alarm_arn" {
  description = "ARN of the ALB no healthy targets alarm"
  value       = aws_cloudwatch_metric_alarm.alb_no_healthy_targets.arn
}

output "alb_response_time_alarm_arn" {
  description = "ARN of the ALB response time alarm"
  value       = aws_cloudwatch_metric_alarm.alb_response_time_high.arn
}

output "alb_5xx_errors_alarm_arn" {
  description = "ARN of the ALB 5XX errors alarm"
  value       = aws_cloudwatch_metric_alarm.alb_5xx_errors.arn
}

output "pipeline_failed_alarm_arn" {
  description = "ARN of the pipeline failure alarm (if enabled)"
  value       = var.enable_pipeline_alarms ? aws_cloudwatch_metric_alarm.pipeline_failed[0].arn : null
}

output "alarm_arns" {
  description = "List of all alarm ARNs"
  value = concat(
    [
      aws_cloudwatch_metric_alarm.ecs_cpu_high.arn,
      aws_cloudwatch_metric_alarm.ecs_memory_high.arn,
      aws_cloudwatch_metric_alarm.ecs_task_count_low.arn,
      aws_cloudwatch_metric_alarm.alb_unhealthy_targets.arn,
      aws_cloudwatch_metric_alarm.alb_no_healthy_targets.arn,
      aws_cloudwatch_metric_alarm.alb_response_time_high.arn,
      aws_cloudwatch_metric_alarm.alb_5xx_errors.arn
    ],
    var.enable_pipeline_alarms ? [aws_cloudwatch_metric_alarm.pipeline_failed[0].arn] : []
  )
}
