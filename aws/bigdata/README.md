# AWS Big Data Module

Root module for AWS big data services including EMR, Glue, Redshift, and Athena.

## Usage

```hcl
module "bigdata" {
  source = "git::https://github.com/raja1417/terraform-modules.git//aws/bigdata?ref=v1.0.0"

  project_name = "finsight"
  environment  = "dev"
  
  tags = {
    Environment = "dev"
  }
}
```
