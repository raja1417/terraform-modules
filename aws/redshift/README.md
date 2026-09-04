# AWS Redshift Cluster

Creates an encrypted Redshift cluster with subnet groups, parameter groups, logging, snapshots, and lifecycle protection.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "redshift" {
  source          = "git::https://github.com/raja1417/terraform-modules.git//aws/redshift?ref=v1.0.0"
  name            = "warehouse"
  database_name   = "analytics"
  master_username = "admin"
  master_password = var.redshift_password
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//aws/redshift` with a pinned tag or commit SHA.
