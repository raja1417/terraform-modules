# AWS Compute Module

Root module for AWS compute resources including EC2, Auto Scaling Groups, and Lambda functions.

## Usage

```hcl
module "compute" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/compute?ref=v1.0.0"

  project_name  = "finsight"
  environment   = "dev"
  instance_type = "t3.micro"
  instance_count = 2
  
  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```

## Requirements

- Terraform >= 1.0
- AWS Provider >= 5.0

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_name | Project name for resource naming | string | n/a | yes |
| environment | Environment name (dev, test, prod) | string | n/a | yes |
| instance_type | EC2 instance type | string | "t3.micro" | no |
| instance_count | Number of instances to create | number | 1 | no |
| tags | Common tags for all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_ids | IDs of created EC2 instances |
| instance_ips | Private IP addresses of instances |
| security_group_id | Security group ID |

## Example

See `example.tf` in this directory.
