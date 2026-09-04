# AWS Application Load Balancer

Creates an ALB with target groups, listeners, access logging, health checks, and deletion protection.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "alb" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/alb?ref=v1.0.0"
  name = "app-prod"
  subnet_ids = module.vpc.public_subnet_ids
  target_groups = { app = { port = 8080, vpc_id = module.vpc.vpc_id } }
  listeners = { https = { port = 443, protocol = "HTTPS", certificate_arn = aws_acm_certificate.app.arn, target_group_key = "app" } }
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//aws/alb` with a pinned tag or commit SHA.
