# AWS Storage Module

Root module for AWS storage resources including S3, RDS, DynamoDB, and EBS.

## Usage

```hcl
module "storage" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/storage?ref=v1.0.0"

  project_name           = "finsight"
  environment            = "dev"
  rds_instance_class     = "db.t3.micro"
  rds_allocated_storage  = 20
  
  tags = {
    Environment = "dev"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_name | Project name for naming | string | n/a | yes |
| environment | Environment (dev, test, prod) | string | n/a | yes |
| rds_instance_class | RDS instance type | string | "db.t3.micro" | no |
| rds_allocated_storage | RDS storage in GB | number | 20 | no |
| tags | Common tags | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| s3_bucket_name | S3 bucket name |
| rds_endpoint | RDS database endpoint |
| rds_port | RDS port |
