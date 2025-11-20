# Monitoring Module Variables

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN of SNS topic for alarm notifications"
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

variable "desired_task_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 2
}

# ALB Configuration
variable "alb_arn_suffix" {
  description = "ARN suffix of the ALB (for CloudWatch metrics)"
  type        = string
}

variable "target_group_arn_suffix" {
  description = "ARN suffix of the target group (for CloudWatch metrics)"
  type        = string
}

# Pipeline Configuration
variable "pipeline_name" {
  description = "Name of the CodePipeline"
  type        = string
  default     = ""
}

variable "enable_pipeline_alarms" {
  description = "Enable CodePipeline alarms"
  type        = bool
  default     = true
}

# ECS CPU Alarm Thresholds
variable "cpu_threshold" {
  description = "CPU utilization threshold percentage"
  type        = number
  default     = 80
}

variable "cpu_evaluation_periods" {
  description = "Number of periods to evaluate for CPU alarm"
  type        = number
  default     = 2
}

variable "cpu_period" {
  description = "Period in seconds for CPU metric"
  type        = number
  default     = 300
}

# ECS Memory Alarm Thresholds
variable "memory_threshold" {
  description = "Memory utilization threshold percentage"
  type        = number
  default     = 80
}

variable "memory_evaluation_periods" {
  description = "Number of periods to evaluate for memory alarm"
  type        = number
  default     = 2
}

variable "memory_period" {
  description = "Period in seconds for memory metric"
  type        = number
  default     = 300
}

# ALB Alarm Thresholds
variable "response_time_threshold" {
  description = "Target response time threshold in seconds"
  type        = number
  default     = 2
}

variable "error_5xx_threshold" {
  description = "Threshold for 5XX errors"
  type        = number
  default     = 10
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
