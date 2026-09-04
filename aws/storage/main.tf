locals {
  common_tags = merge(
    var.tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# Example: S3 Bucket
resource "aws_s3_bucket" "storage" {
  bucket = "${var.project_name}-${var.environment}-bucket-${data.aws_caller_identity.current.account_id}"

  tags = local.common_tags
}

data "aws_caller_identity" "current" {}
