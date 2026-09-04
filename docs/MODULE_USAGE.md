# Module Usage Guide

## Overview

This guide explains how to use modules from the `terraform-modules` repository in your application repos.

## Directory Structure

### Wrappers (Environment-Specific Configurations)

Each environment (dev/test/prod) has its own wrapper directory:

```
wrappers/
├── dev/
│   ├── variables.tf       # Environment-specific variable definitions
│   ├── terraform.tfvars   # Environment-specific values (auto-loaded)
│   ├── main.tf            # Module instantiations
│   ├── outputs.tf         # Environment outputs
│   └── backend.tf         # State backend configuration
├── test/
│   └── (same structure as dev)
├── prod/
│   └── (same structure as dev)
└── shared/
    └── variables.tf       # Shared variables inherited by all envs
```

## Key Concepts

### 1. **variables.tf** - Variable Definitions

Defines what variables your environment can accept:

```hcl
# wrappers/dev/variables.tf
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
```

### 2. **terraform.tfvars** - Variable Values (Auto-Loaded)

Provides actual values for variables - **auto-loaded by Terraform**:

```hcl
# wrappers/dev/terraform.tfvars
project_name    = "finsight-dev"
environment      = "dev"
region           = "us-east-1"
instance_type   = "t3.micro"
```

✅ No need to pass `-var` flags; Terraform automatically loads `*.tfvars` files.

### 3. **main.tf** - Module Instantiations

References modules from terraform-modules repo and passes variables:

```hcl
# wrappers/dev/main.tf
module "vm" {
  source = "git::https://github.com/raja1417/terraform-modules.git//modules/aws/compute/vm?ref=v1.0.0"
  
  project_name  = var.project_name
  environment   = var.environment
  instance_type = var.instance_type
}
```

### 4. **backend.tf** - State Management

Configures where Terraform stores state (per environment):

```hcl
# wrappers/dev/backend.tf
terraform {
  backend "s3" {
    bucket         = "terraform-state-dev"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks-dev"
  }
}
```

### 5. **shared/variables.tf** - Inherited Variables

Common variables shared across all environments:

```hcl
# wrappers/shared/variables.tf
variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment: dev, test, prod"
  type        = string
}
```

## Usage Workflow

### Step 1: Choose Your Environment

```bash
cd terraform/wrappers/dev    # or test, or prod
```

### Step 2: Initialize Terraform

```bash
terraform init
```

### Step 3: Plan Changes

```bash
# terraform.tfvars is auto-loaded
terraform plan
```

### Step 4: Apply Changes

```bash
# terraform.tfvars is auto-loaded
terraform apply
```

### Step 5: Override Values (Optional)

```bash
# Override via CLI flag
terraform apply -var="instance_type=t3.small"

# Or use alternate var file
terraform apply -var-file="custom.tfvars"
```

## Example: Deploying to AWS

### 1. Set Up Dev Environment

```bash
cd terraform/wrappers/dev
terraform init
terraform plan   # Review changes
terraform apply  # Deploy to dev (uses dev/terraform.tfvars)
```

### 2. Promote to Test

```bash
cd ../test
terraform init
terraform plan   # Review changes with test values
terraform apply  # Deploy to test (uses test/terraform.tfvars)
```

### 3. Deploy to Production

```bash
cd ../prod
terraform init
terraform plan   # Review changes with prod values
terraform apply  # Deploy to prod (uses prod/terraform.tfvars)
```

## Multi-Cloud Support (AWS + Azure)

### For AWS:

```hcl
# wrappers/dev/main.tf
module "networking" {
  source = "git::https://github.com/raja1417/terraform-modules.git//modules/aws/networking?ref=v1.0.0"
  # ...
}
```

### For Azure:

```hcl
# wrappers/dev/main.tf
module "networking" {
  source = "git::https://github.com/raja1417/terraform-modules.git//modules/azure/networking?ref=v1.0.0"
  # ...
}
```

## Module Versioning

Always reference specific versions:

```hcl
# ✅ Good - Specific version
source = "git::https://github.com/raja1417/terraform-modules.git//modules/aws/compute?ref=v1.0.0"

# ❌ Bad - Latest version (unpredictable)
source = "git::https://github.com/raja1417/terraform-modules.git//modules/aws/compute?ref=main"
```

## Directory Hierarchy for App Repos

Your app repos (finsight-ai-platform, pawpal-pet-wellness) should have:

```
finsight-ai-platform/
├── app-code/          # Your application code
├── helm/              # Helm charts for K8s deployment
├── terraform/
│   ├── wrappers/
│   │   ├── dev/
│   │   ├── test/
│   │   └── prod/
│   └── modules/       # App-specific overrides (optional)
└── .github/
    └── workflows/     # CI/CD workflows from github-actions-workflows repo
```

## Benefits of This Structure

✅ **Separation of Concerns** - Modules are defined centrally, wrappers customize per environment

✅ **DRY (Don't Repeat Yourself)** - Shared variables in `shared/variables.tf`

✅ **Environment Isolation** - dev, test, prod have separate state, configs, values

✅ **Version Control** - Git tags ensure reproducible deployments

✅ **Easy Promotion** - Promote from dev → test → prod by changing directory

✅ **Auto-Loaded Configs** - `terraform.tfvars` loaded automatically, no manual `-var` flags
