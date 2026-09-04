# AWS EC2 Instance

Creates a hardened EC2 instance with encrypted volumes, IMDSv2, optional EIP, dynamic EBS devices, and lifecycle protections.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "ec2" {
  source             = "git::https://github.com/raja1417/terraform-modules.git//aws/ec2?ref=v1.0.0"
  name               = "app-01"
  ami_id             = "ami-0123456789abcdef0"
  subnet_id          = module.vpc.private_subnet_ids[0]
  security_group_ids = [module.web_sg.id]
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//aws/ec2` with a pinned tag or commit SHA.
