# Module Usage Guide

Use this repository only as a source for reusable AWS and Azure resource modules. Do not place wrappers, environment directories, backend configuration, tfvars files, or application-specific Terraform here.

## Consuming a Module

```hcl
module "s3" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/s3?ref=v1.0.0"

  name = "my-company-artifacts-prod"
}
```

## App Repository Responsibilities

Application repositories should own:

- `terraform/wrappers/dev`, `terraform/wrappers/test`, and `terraform/wrappers/prod`.
- Backend configuration and provider aliases.
- Environment-specific values and secrets integration.
- Kubernetes, Helm, and application CI/CD workflows.

## Validation

Run `terraform fmt -recursive -check` and `terraform validate` per module after initializing providers.
