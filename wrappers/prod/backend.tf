# Production Environment - Terraform State Backend
# Configure remote state storage for prod environment with high security

terraform {
  backend "s3" {
    bucket         = "terraform-state-prod"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks-prod"
  }
}

# Alternative: Local state (for testing)
# Uncomment below and comment out S3 backend for local development
# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }
