# Azure Big Data Module

Root module for Azure big data services including Databricks, Synapse, and HDInsight.

## Usage

```hcl
module "bigdata" {
  source = "git::https://github.com/raja1417/terraform-modules.git//azure/bigdata?ref=v1.0.0"

  resource_group_name = azurerm_resource_group.main.name
  location            = "East US"
  project_name        = "finsight"
  
  tags = {
    Environment = "dev"
  }
}
```
