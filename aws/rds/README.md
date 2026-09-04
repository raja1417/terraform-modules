# AWS RDS Database

Creates an encrypted RDS instance with backups, Multi-AZ, monitoring, log exports, and deletion protection.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "db" {
  source   = "git::https://github.com/raja1417/terraform-modules.git//aws/rds?ref=v1.0.0"
  name     = "orders-prod"
  username = "dbadmin"
  subnet_ids = module.vpc.private_subnet_ids
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//aws/rds` with a pinned tag or commit SHA.
