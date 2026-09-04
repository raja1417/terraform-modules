# AWS Security Group

Creates one security group with dynamic ingress and egress rules.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "web_sg" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/security-group?ref=v1.0.0"
  name   = "web-sg"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [{ from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["10.0.0.0/8"] }]
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//aws/security-group` with a pinned tag or commit SHA.
