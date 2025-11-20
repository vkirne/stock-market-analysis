# Staging Environment Configuration
# Balanced between cost and reliability

environment = "staging"
aws_region  = "us-east-1"

# Network Configuration
vpc_cidr           = "10.1.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b"]

# ECS Configuration - Moderate resources for staging
ecs_task_cpu       = "512"
ecs_task_memory    = "1024"
ecs_desired_count  = 1
ecs_container_port = 8080

# Cost Optimization - Single NAT Gateway
enable_nat_gateway = true
single_nat_gateway = true

# Monitoring Configuration
enable_container_insights = true
log_retention_days        = 7

# ECR Configuration
ecr_image_retention_count = 10

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
