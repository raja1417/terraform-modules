# AWS DynamoDB Table

Creates an encrypted DynamoDB table with PITR, streams, TTL, and dynamic indexes.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "table" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/dynamodb?ref=v1.0.0"
  name = "orders"
  hash_key = "pk"
  attributes = [{ name = "pk", type = "S" }]
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//aws/dynamodb` with a pinned tag or commit SHA.
