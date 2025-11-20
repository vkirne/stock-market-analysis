# Development Environment Configuration
# Optimized for cost savings

environment = "dev"
aws_region  = "us-east-1"

# Network Configuration
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b"]

# ECS Configuration - Minimal resources for dev
ecs_task_cpu       = "256"
ecs_task_memory    = "512"
ecs_desired_count  = 1
ecs_container_port = 8080

# Cost Optimization - Single NAT Gateway
enable_nat_gateway = true
single_nat_gateway = true

# Monitoring Configuration
enable_container_insights = false  # Disable to save costs
log_retention_days        = 3      # Short retention for dev

# ECR Configuration
ecr_image_retention_count = 5  # Keep fewer images in dev

# ALB Configuration
alb_health_check_path      = "/"
alb_health_check_interval  = 30
alb_health_check_timeout   = 5
alb_healthy_threshold      = 2
alb_unhealthy_threshold    = 3

# CodeBuild Configuration
codebuild_compute_type = "BUILD_GENERAL1_SMALL"
codebuild_image        = "aws/codebuild/standard:7.0"

# Notification Configuration
notification_email = ""  # Add your email for notifications
