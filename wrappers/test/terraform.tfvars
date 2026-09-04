# Test Environment Terraform Values
# Auto-loaded by terraform apply -var-file=terraform.tfvars

project_name    = "finsight-test"
environment      = "test"
region           = "us-east-1"
cloud_provider   = "aws"

instance_type              = "t3.small"
kubernetes_version         = "1.27"
enable_monitoring          = true
rds_allocated_storage      = 50
rds_instance_class         = "db.t3.small"

tags = {
  ManagedBy   = "Terraform"
  Environment = "test"
  Repository  = "terraform-modules"
  CostCenter  = "engineering"
}
