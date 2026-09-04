# Azure SQL Database

Creates Azure SQL server/database with AAD-ready identity, retention policies, firewall rules, and encryption defaults.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "sql" { source = "git::https://github.com/raja1417/terraform-modules.git//azure/sql-db?ref=v1.0.0" server_name = "orders-sql-prod" name = "orders" resource_group_name = azurerm_resource_group.rg.name location = azurerm_resource_group.rg.location administrator_login = var.sql_admin administrator_password = var.sql_password }
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//azure/sql-db` with a pinned tag or commit SHA.
