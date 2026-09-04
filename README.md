# Terraform Modules Repository

Shared, reusable Terraform root modules for AWS and Azure resources.

**This repository contains cloud provider root modules ONLY.**
**App-specific wrappers, environments, and configurations belong in application repositories.**

## Directory Structure

```
terraform-modules/
├── aws/
│   ├── compute/                   # EC2, ASG, Lambda modules
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── README.md
│   ├── storage/                   # S3, RDS, DynamoDB modules
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── README.md
│   ├── networking/                # VPC, ALB, Route53, Security Groups
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── README.md
│   ├── kubernetes/                # EKS cluster and related
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── README.md
│   └── bigdata/                   # EMR, Glue, Redshift, Athena
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── providers.tf
│       └── README.md
├── azure/
│   ├── compute/                   # VMs, VMSS, App Service modules
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── README.md
│   ├── storage/                   # Blob, SQL, CosmosDB modules
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── README.md
│   ├── networking/                # VNets, NSGs, Load Balancers
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── README.md
│   ├── kubernetes/                # AKS cluster and related
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── README.md
│   └── bigdata/                   # Databricks, Synapse, HDInsight
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── providers.tf
│       └── README.md
├── docs/
│   ├── MODULE_USAGE.md            # How to consume these modules
│   ├── MODULE_DEVELOPMENT.md      # How to develop new modules
│   ├── AWS_MODULES.md             # AWS module catalog
│   ├── AZURE_MODULES.md           # Azure module catalog
│   └── CONTRIBUTING.md
├── .github/
│   └── workflows/
│       ├── validate-modules.yml   # Validate Terraform syntax
│       └── test-modules.yml       # Test modules
├── .gitignore
├── LICENSE
└── README.md
```

## Module Structure

Each module directory contains:

### main.tf
Resource definitions and module composition

### variables.tf
Input variable definitions with validation rules

### outputs.tf
Output values to be consumed by wrapper configs

### providers.tf
Provider requirements and configuration

### README.md
Module documentation with examples

## Usage Example

In your **application repository** (`finsight-ai-platform/terraform/wrappers/dev/main.tf`):

```hcl
module "vpc" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/networking?ref=v1.0.0"

  project_name = var.project_name
  environment  = var.environment
  cidr_block   = "10.0.0.0/16"
  
  tags = var.tags
}

module "eks" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/kubernetes?ref=v1.0.0"

  cluster_name       = "${var.project_name}-${var.environment}-eks"
  kubernetes_version = "1.27"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
  
  tags = var.tags
}
```

## Versioning

Use git tags to version modules:

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

Always reference specific versions in your wrapper configs:

```hcl
source = "git::https://github.com/raja1417/terraform-modules.git//aws/networking?ref=v1.0.0"
```

## Module Development

See [MODULE_DEVELOPMENT.md](docs/MODULE_DEVELOPMENT.md) for guidelines on:
- Creating new modules
- Variable naming conventions
- Output standards
- Testing modules
- Documentation requirements

## Module Catalog

- [AWS Modules](docs/AWS_MODULES.md)
- [Azure Modules](docs/AZURE_MODULES.md)

## Getting Started

1. Review module catalog in `docs/`
2. Check individual module READMEs for usage examples
3. Reference modules in your app repo wrappers using git source with version tags
4. Keep wrappers and environments in app-specific repositories

## Contributing

See [CONTRIBUTING.md](docs/CONTRIBUTING.md)

## License

MIT
