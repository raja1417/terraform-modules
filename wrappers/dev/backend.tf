# Development Environment - Terraform State Backend
# Configure remote state storage for dev environment

terraform {
  backend "s3" {
    bucket         = "terraform-state-dev"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks-dev"
  }
}

# Alternative: Local state (for testing)
# Uncomment below and comment out S3 backend for local development
# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }
