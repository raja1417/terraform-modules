# Production Environment - Module Instantiations
# This wrapper file references modules from the terraform-modules repository
# Production should have HA and security best practices enabled

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = var.tags
  }
}

# Example: VPC Networking Module (AWS)
# module "networking" {
#   source = "git::https://github.com/raja1417/terraform-modules.git//modules/aws/networking?ref=v1.0.0"
#
#   project_name = var.project_name
#   environment  = var.environment
#   region       = var.region
#   cidr_block   = "10.2.0.0/16"
#   enable_nat   = true
#   multi_az     = true
# }

# Example: EKS Kubernetes Module (AWS)
# module "kubernetes" {
#   source = "git::https://github.com/raja1417/terraform-modules.git//modules/aws/kubernetes/eks?ref=v1.0.0"
#
#   project_name       = var.project_name
#   environment        = var.environment
#   kubernetes_version = var.kubernetes_version
#   vpc_id             = module.networking.vpc_id
#   subnet_ids         = module.networking.private_subnet_ids
#   desired_capacity   = 3
#   enable_autoscaling = true
# }

# Example: RDS Database Module (AWS)
# module "database" {
#   source = "git::https://github.com/raja1417/terraform-modules.git//modules/aws/storage/rds?ref=v1.0.0"
#
#   project_name           = var.project_name
#   environment            = var.environment
#   allocated_storage      = var.rds_allocated_storage
#   instance_class         = var.rds_instance_class
#   vpc_security_group_ids = [module.networking.db_security_group_id]
#   multi_az               = true
#   backup_retention_days  = var.backup_retention_days
#   enable_encryption      = true
# }

# Example: S3 Storage Module (AWS)
# module "storage" {
#   source = "git::https://github.com/raja1417/terraform-modules.git//modules/aws/storage/s3?ref=v1.0.0"
#
#   project_name      = var.project_name
#   environment       = var.environment
#   bucket_name       = "${var.project_name}-${var.environment}-bucket"
#   enable_versioning = true
#   enable_encryption = true
# }
