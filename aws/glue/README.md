# AWS Glue

Creates Glue catalog databases, security configuration, crawlers, and jobs with dynamic defaults.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "glue" { source = "git::https://github.com/raja1417/terraform-modules.git//aws/glue?ref=v1.0.0" name = "analytics" catalog_databases = { raw = {} } }
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//aws/glue` with a pinned tag or commit SHA.
