# AWS VPC

Creates a VPC with public/private subnets, route tables, optional NAT gateways, and DNS defaults.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "vpc" {
  source     = "git::https://github.com/raja1417/terraform-modules.git//aws/vpc?ref=v1.0.0"
  name       = "platform-prod"
  cidr_block = "10.0.0.0/16"
  subnets = { public-a = { cidr_block = "10.0.1.0/24", public = true }, private-a = { cidr_block = "10.0.11.0/24" } }
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//aws/vpc` with a pinned tag or commit SHA.
