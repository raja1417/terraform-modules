# Azure Synapse Workspace

Creates a Synapse workspace with SQL and Spark pools, firewall rules, managed identity, and lifecycle safeguards.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "synapse" {
  source                               = "git::https://github.com/raja1417/terraform-modules.git//azure/synapse?ref=v1.0.0"
  name                                 = "analytics-syn"
  resource_group_name                  = azurerm_resource_group.rg.name
  location                             = azurerm_resource_group.rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.fs.id
  sql_administrator_login              = var.synapse_admin
  sql_administrator_login_password     = var.synapse_password
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//azure/synapse` with a pinned tag or commit SHA.
