# Terraform Modules Repository

Shared, reusable Terraform root modules for AWS and Azure resources.

This repository contains cloud-provider root modules only. Application-specific wrappers, backend configuration, environment values, Kubernetes manifests, and CI/CD callers belong in application repositories.

## Directory Structure

```text
terraform-modules/
├── aws/
│   ├── alb/
│   ├── dynamodb/
│   ├── ec2/
│   ├── eks/
│   ├── emr/
│   ├── glue/
│   ├── lambda/
│   ├── rds/
│   ├── redshift/
│   ├── s3/
│   ├── security-group/
│   └── vpc/
├── azure/
│   ├── aks/
│   ├── app-service/
│   ├── blob-storage/
│   ├── cosmosdb/
│   ├── databricks/
│   ├── sql-db/
│   ├── synapse/
│   ├── vm/
│   └── vnet/
├── docs/
├── .github/workflows/
├── .gitignore
├── LICENSE
└── README.md
```

## Module Contract

Each module includes:

- `main.tf` resource definitions with lifecycle controls, conditional resources, and dynamic blocks.
- `variables.tf` strongly typed inputs with validation and secure defaults.
- `outputs.tf` values for consuming wrappers.
- `providers.tf` Terraform and provider requirements.
- `locals.tf` shared computed values such as normalized tags.
- `README.md` module usage documentation.

## Example

```hcl
module "vpc" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/vpc?ref=v1.0.0"

  name       = "platform-prod"
  cidr_block = "10.0.0.0/16"
  subnets = {
    public-a  = { cidr_block = "10.0.1.0/24", public = true }
    private-a = { cidr_block = "10.0.11.0/24" }
  }
}
```

Pin module references to immutable tags or commit SHAs in application repositories.
