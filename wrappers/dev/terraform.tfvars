# Development Environment Terraform Values
# Auto-loaded by terraform apply -var-file=terraform.tfvars

project_name    = "finsight-dev"
environment      = "dev"
region           = "us-east-1"
cloud_provider   = "aws"

instance_type              = "t3.micro"
kubernetes_version         = "1.27"
enable_monitoring          = true
rds_allocated_storage      = 20
rds_instance_class         = "db.t3.micro"

tags = {
  ManagedBy   = "Terraform"
  Environment = "dev"
  Repository  = "terraform-modules"
  CostCenter  = "engineering"
}
