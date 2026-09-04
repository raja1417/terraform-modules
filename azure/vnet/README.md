# Azure Virtual Network

Creates a virtual network with subnets, delegations, service endpoints, route tables, and associations.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "vnet" { source = "git::https://github.com/raja1417/terraform-modules.git//azure/vnet?ref=v1.0.0" name = "platform-prod" resource_group_name = azurerm_resource_group.rg.name location = azurerm_resource_group.rg.location address_space = ["10.10.0.0/16"] }
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//azure/vnet` with a pinned tag or commit SHA.
