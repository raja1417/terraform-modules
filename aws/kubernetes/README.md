# AWS Kubernetes Module

Root module for AWS EKS cluster and related resources.

## Usage

```hcl
module "kubernetes" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/kubernetes?ref=v1.0.0"

  cluster_name       = "finsight-dev-eks"
  kubernetes_version = "1.27"
  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.private_subnet_ids
  
  tags = {
    Environment = "dev"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| cluster_name | EKS cluster name | string | n/a | yes |
| kubernetes_version | Kubernetes version | string | "1.27" | no |
| vpc_id | VPC ID | string | n/a | yes |
| subnet_ids | Subnet IDs | list(string) | n/a | yes |
| tags | Common tags | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | EKS cluster ID |
| cluster_endpoint | EKS cluster endpoint |
| cluster_version | Kubernetes version |
