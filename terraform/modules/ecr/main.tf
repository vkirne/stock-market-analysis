# ECR Module
# Creates ECR repository for Docker images

# ECR Repository
resource "aws_ecr_repository" "main" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability

  # Enable image scanning on push for vulnerability detection
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  # Enable encryption at rest
  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.kms_key_id
  }

  tags = var.tags
}

# ECR Lifecycle Policy
# Automatically delete old images to save storage costs
resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last ${var.image_retention_count} images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = var.image_retention_count
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

# ECR Repository Policy (optional)
# Allows specific AWS accounts or services to pull images
resource "aws_ecr_repository_policy" "main" {
  count = var.repository_policy != null ? 1 : 0

  repository = aws_ecr_repository.main.name
  policy     = var.repository_policy
}
