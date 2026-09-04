# AWS EKS Cluster

Creates an EKS control plane with encrypted secrets, log exports, managed node groups, taints, labels, and add-ons.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "eks" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/eks?ref=v1.0.0"
  name = "platform-prod"
  cluster_role_arn = aws_iam_role.eks.arn
  node_role_arn = aws_iam_role.nodes.arn
  subnet_ids = module.vpc.private_subnet_ids
  node_groups = { default = { desired_size = 2, min_size = 1, max_size = 5 } }
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//aws/eks` with a pinned tag or commit SHA.
