# AWS Networking Module

Root module for AWS networking including VPC, subnets, Route53, ALB, and Security Groups.

## Usage

```hcl
module "networking" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/networking?ref=v1.0.0"

  project_name = "finsight"
  environment  = "dev"
  cidr_block   = "10.0.0.0/16"
  
  tags = {
    Environment = "dev"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_name | Project name | string | n/a | yes |
| environment | Environment (dev, test, prod) | string | n/a | yes |
| cidr_block | VPC CIDR block | string | "10.0.0.0/16" | no |
| tags | Common tags | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC ID |
| vpc_cidr | VPC CIDR block |
| public_subnet_ids | Public subnet IDs |
| private_subnet_ids | Private subnet IDs |
