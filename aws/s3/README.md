# AWS S3 Bucket

Creates an encrypted, private S3 bucket with versioning, public-access controls, logging, and dynamic lifecycle policies.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "artifacts" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/s3?ref=v1.0.0"
  name   = "my-company-artifacts-prod"
  lifecycle_rules = [{ id = "archive", transitions = [{ days = 30, storage_class = "STANDARD_IA" }] }]
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//aws/s3` with a pinned tag or commit SHA.
