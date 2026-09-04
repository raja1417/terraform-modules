# Azure App Service

Creates an App Service plan, Linux web app, deployment slots, identity, logs, app settings, and secure HTTPS defaults.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "app" { source = "git::https://github.com/raja1417/terraform-modules.git//azure/app-service?ref=v1.0.0" name = "orders-api" resource_group_name = azurerm_resource_group.rg.name location = azurerm_resource_group.rg.location }
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//azure/app-service` with a pinned tag or commit SHA.
