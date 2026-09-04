# AWS EMR Cluster

Creates an EMR cluster with managed scaling, bootstrap actions, steps, logging, and lifecycle controls.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "emr" {
  source        = "git::https://github.com/raja1417/terraform-modules.git//aws/emr?ref=v1.0.0"
  name          = "analytics"
  service_role  = aws_iam_role.emr.arn
  job_flow_role = aws_iam_instance_profile.emr.arn
  subnet_id     = module.vpc.private_subnet_ids[0]
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//aws/emr` with a pinned tag or commit SHA.
