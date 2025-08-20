resource "aws_ecr_repository" "ecr_repo" {
    name                    = var.ecr_name
    image_tag_mutability    = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = var.scan_on_push
  }

  tags = {
        Name = var.ecr_name
    }
}


data "aws_caller_identity" "current" {}


resource "aws_ecr_repository_policy" "default" {
    repository = aws_ecr_repository.ecr_repo.name
    policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Sid    = "AllowAccountFullAccess"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action = "ecr:*"
      }
    ]
  })
}