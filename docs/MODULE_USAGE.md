# Module Usage Guide

## Overview

This guide explains how to use root modules from `terraform-modules` in your application repositories.

## Key Principles

✅ **terraform-modules repo contains:**
- Root modules organized by cloud provider (aws/, azure/)
- Provider configurations
- Generic, reusable infrastructure code
- Module documentation
- Tests and validation

✅ **Application repos contain:**
- Environment-specific wrappers (terraform/wrappers/dev|test|prod/)
- Application-specific variables and configurations
- main.tf that calls terraform-modules
- Backend configurations
- Helm charts and Kubernetes manifests
- CI/CD workflows

## Directory Structure in App Repos

```
finsight-ai-platform/
├── terraform/
│   ├── wrappers/
│   │   ├── shared/
│   │   │   └── variables.tf          # Shared variables
│   │   ├── dev/
│   │   │   ├── variables.tf          # Dev-specific definitions
│   │   │   ├── terraform.tfvars      # Dev values (auto-loaded)
│   │   │   ├── main.tf               # Calls modules from terraform-modules
│   │   │   ├── outputs.tf            # Dev outputs
│   │   └── backend.tf
│   │   ├── test/
│   │   │   ├── variables.tf
│   │   │   ├── terraform.tfvars
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   └── backend.tf
│   │   ├── prod/
│   │   │   ├── variables.tf
│   │   │   ├── terraform.tfvars
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   └── backend.tf
├── helm/
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── values-dev.yaml
│   ├── values-test.yaml
│   ├── values-prod.yaml
│   └── templates/
├── .github/
│   └── workflows/
│       ├── deploy-dev.yml      # Calls from github-actions-workflows
│       ├── deploy-test.yml
│       └── deploy-prod.yml
├── app-code/
└── README.md
```

## Usage Example

### 1. Shared Variables

```hcl
# terraform/wrappers/shared/variables.tf
variable "project_name" {
  type = string
}

variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}

variable "region" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
```

### 2. Environment-Specific Variables

```hcl
# terraform/wrappers/dev/variables.tf
variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "rds_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "rds_allocated_storage" {
  type    = number
  default = 20
}
```

### 3. Environment Values

```hcl
# terraform/wrappers/dev/terraform.tfvars
project_name           = "finsight"
environment            = "dev"
region                 = "us-east-1"
instance_type          = "t3.micro"
rds_instance_class     = "db.t3.micro"
rds_allocated_storage  = 20

tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
  Project     = "finsight"
}
```

### 4. Call Terraform Modules

```hcl
# terraform/wrappers/dev/main.tf
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

# Call networking module from terraform-modules repo
module "networking" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/networking?ref=v1.0.0"

  project_name = var.project_name
  environment  = var.environment
  cidr_block   = "10.0.0.0/16"
  tags         = var.tags
}

# Call compute module from terraform-modules repo
module "compute" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/compute?ref=v1.0.0"

  project_name  = var.project_name
  environment   = var.environment
  instance_type = var.instance_type
  tags          = var.tags
}

# Call storage module from terraform-modules repo
module "storage" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/storage?ref=v1.0.0"

  project_name          = var.project_name
  environment           = var.environment
  rds_instance_class    = var.rds_instance_class
  rds_allocated_storage = var.rds_allocated_storage
  tags                  = var.tags
}

# Call Kubernetes module from terraform-modules repo
module "kubernetes" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/kubernetes?ref=v1.0.0"

  cluster_name       = "${var.project_name}-${var.environment}-eks"
  kubernetes_version = "1.27"
  vpc_id             = module.networking.vpc_id
  subnet_ids         = ["subnet-123"]  # From networking module
  tags               = var.tags
}
```

### 5. Outputs

```hcl
# terraform/wrappers/dev/outputs.tf
output "vpc_id" {
  value = module.networking.vpc_id
}

output "eks_cluster_id" {
  value = module.kubernetes.cluster_id
}

output "s3_bucket_name" {
  value = module.storage.s3_bucket_name
}
```

### 6. Backend Configuration

```hcl
# terraform/wrappers/dev/backend.tf
terraform {
  backend "s3" {
    bucket         = "terraform-state-dev"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks-dev"
  }
}

# For local development, use local backend:
# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }
```

## Deployment Workflow

### For Dev Environment

```bash
cd terraform/wrappers/dev
terraform init
terraform plan        # Review changes
terraform apply       # Deploy
```

### For Test Environment

```bash
cd terraform/wrappers/test
terraform init
terraform plan
terraform apply
```

### For Production

```bash
cd terraform/wrappers/prod
terraform init
terraform plan
terraform apply       # Requires approval via GitHub environment protection
```

## Best Practices

✅ **Always:**
- Use specific module versions: `ref=v1.0.0` (not `ref=main`)
- Keep wrappers in app repos, modules in terraform-modules repo
- Use terraform.tfvars for environment values
- Store state in remote backend (S3, Terraform Cloud)
- Review terraform plan before applying
- Use separate AWS credentials per environment

❌ **Never:**
- Commit tfstate files to git
- Use `@main` for module references
- Mix environments in same wrapper
- Store secrets in terraform.tfvars (use AWS Secrets Manager)
- Apply without reviewing plan

## Multi-Cloud Example

To use Azure modules instead of AWS:

```hcl
# terraform/wrappers/dev/main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "networking" {
  source = "git::https://github.com/raja1417/terraform-modules.git//azure/networking?ref=v1.0.0"

  resource_group_name = azurerm_resource_group.main.name
  location            = "East US"
  project_name        = var.project_name
  tags                = var.tags
}
```

## Troubleshooting

### Module Source Not Found

```
Error: No module sources matching pattern
```

**Solution:** Verify:
1. Repository name is correct: `terraform-modules`
2. Path is correct: `//aws/networking` (not `/aws/networking`)
3. Version tag exists: `git tag -l` in terraform-modules repo

### Variable Not Defined

```
Error: Reference to undeclared variable "instance_type"
```

**Solution:**
1. Add variable to `wrappers/dev/variables.tf`
2. Add value to `wrappers/dev/terraform.tfvars`
3. Verify variable is in correct environment directory
