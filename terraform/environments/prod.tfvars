# Production Environment Configuration
# Optimized for reliability and high availability

environment = "prod"
aws_region  = "us-east-1"

# Network Configuration
vpc_cidr           = "10.2.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b"]

# ECS Configuration - Full resources for production
ecs_task_cpu       = "512"
ecs_task_memory    = "1024"
ecs_desired_count  = 2  # High availability with 2 tasks
ecs_container_port = 8080

# High Availability - NAT Gateway per AZ
enable_nat_gateway = true
single_nat_gateway = false  # One NAT per AZ for redundancy

# Monitoring Configuration
enable_container_insights = true
log_retention_days        = 30  # Longer retention for production

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
