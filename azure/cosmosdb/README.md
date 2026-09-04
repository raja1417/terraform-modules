# Azure Cosmos DB

Creates a Cosmos DB account with SQL databases/containers, backup, consistency, indexing, and geo-replication.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "cosmos" {
  source              = "git::https://github.com/raja1417/terraform-modules.git//azure/cosmosdb?ref=v1.0.0"
  name                = "orders-cosmos"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//azure/cosmosdb` with a pinned tag or commit SHA.
