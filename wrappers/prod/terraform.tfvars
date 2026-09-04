# Production Environment Terraform Values
# Auto-loaded by terraform apply -var-file=terraform.tfvars

project_name    = "finsight-prod"
environment      = "prod"
region           = "us-east-1"
cloud_provider   = "aws"

instance_type              = "t3.medium"
kubernetes_version         = "1.27"
enable_monitoring          = true
rds_allocated_storage      = 200
rds_instance_class         = "db.t3.large"
enable_backup              = true
backup_retention_days      = 30

tags = {
  ManagedBy   = "Terraform"
  Environment = "prod"
  Repository  = "terraform-modules"
  CostCenter  = "engineering"
  Compliance  = "required"
}
