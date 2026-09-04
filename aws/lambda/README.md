# AWS Lambda Function

Creates a Lambda function with encrypted environment support, layers, VPC config, aliases, and event sources.

## Features

- Resource-specific root module; no environment wrapper logic.
- Strongly typed inputs with validations and secure defaults.
- Conditional resources through `count` and `for_each`.
- Dynamic nested blocks for flexible production configuration.
- Lifecycle settings for safer replacement and drift tolerance.
- Consistent tagging through `var.tags` and module metadata.

## Usage

```hcl
module "worker" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/lambda?ref=v1.0.0"
  name = "orders-worker"
  runtime = "python3.12"
  handler = "app.handler"
  role_arn = aws_iam_role.lambda.arn
  s3_bucket = aws_s3_bucket.artifacts.id
  s3_key = "lambda/orders.zip"
}
```

## Notes

Keep backend configuration, provider aliases, environment values, and application-specific wrappers in the consuming application repository. Reference this module using `//aws/lambda` with a pinned tag or commit SHA.
