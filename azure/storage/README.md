# Azure Storage Module

Root module for Azure storage including Blob Storage, SQL Database, and CosmosDB.

## Usage

```hcl
module "storage" {
  source = "git::https://github.com/raja1417/terraform-modules.git//azure/storage?ref=v1.0.0"

  resource_group_name = azurerm_resource_group.main.name
  location            = "East US"
  project_name        = "finsight"
  
  tags = {
    Environment = "dev"
  }
}
```
