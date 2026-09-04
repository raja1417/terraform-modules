# Terraform Modules Repository

Shared, reusable Terraform modules for AWS and Azure resources spanning compute, storage, networking, Kubernetes, and big data infrastructure.

## Directory Structure

```
terraform-modules/
├── modules/                    # Reusable module definitions
│   ├── aws/
│   │   ├── compute/           # EC2, ASG, Lambda
│   │   ├── storage/           # S3, RDS, DynamoDB
│   │   ├── networking/        # VPC, ALB, Route53
│   │   ├── kubernetes/        # EKS
│   │   └── bigdata/           # EMR, Glue, Redshift
│   ├── azure/
│   │   ├── compute/           # VMs, AKS
│   │   ├── storage/           # Blob, SQL, CosmosDB
│   │   ├── networking/        # VNets, Load Balancers
│   │   ├── kubernetes/        # AKS
│   │   └── bigdata/           # Databricks, Synapse
│   └── common/
│       ├── monitoring/
│       └── security/
│
├── wrappers/                   # Environment-specific wrapper configurations
│   ├── dev/
│   │   ├── terraform.tfvars    # Dev environment values
│   │   ├── variables.tf        # Dev variable definitions
│   │   ├── main.tf             # Dev main configuration
│   │   ├── outputs.tf          # Dev outputs
│   │   └── backend.tf          # Dev backend state
│   ├── test/
│   │   ├── terraform.tfvars
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── backend.tf
│   ├── prod/
│   │   ├── terraform.tfvars
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── backend.tf
│   └── shared/                 # Shared wrapper code
│       └── variables.tf
│
├── examples/                   # Example usage patterns
│   ├── aws-complete-stack/
│   ├── azure-complete-stack/
│   └── multi-cloud-deployment/
│
├── docs/                       # Documentation
│   ├── MODULE_USAGE.md
│   ├── CONTRIBUTING.md
│   └── EXAMPLES.md
│
└── .github/
    └── workflows/
        ├── validate.yml        # Validate Terraform configs
        └── test.yml            # Test modules
```

## Usage

### For App Repositories

Your app repos (finsight-ai-platform, pawpal-pet-wellness) will have:

```hcl
# terraform/wrappers/dev/main.tf
module "vm" {
  source = "git::https://github.com/raja1417/terraform-modules.git//modules/aws/compute/vm?ref=v1.0.0"
  
  environment = var.environment
  instance_type = var.instance_type
  # ... other variables
}
```

### Environment Structure

Each environment (dev/test/prod) has:
- **variables.tf** - Environment-specific variable definitions
- **terraform.tfvars** - Environment-specific values (auto-loaded)
- **main.tf** - Module instantiations using `source` references
- **outputs.tf** - Environment outputs
- **backend.tf** - State backend configuration per environment

## Versioning

Use git tags for module versions:
```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

Reference specific versions in your wrapper configs:
```hcl
source = "git::https://github.com/raja1417/terraform-modules.git//modules/aws/compute?ref=v1.0.0"
```

## Getting Started

1. Review examples in `examples/`
2. Check `docs/MODULE_USAGE.md` for detailed module documentation
3. Use wrapper templates from `wrappers/` as starting points
4. Reference modules with git source and version tags

## Contributing

See [CONTRIBUTING.md](docs/CONTRIBUTING.md)
