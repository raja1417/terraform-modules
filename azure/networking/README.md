# Azure Networking Module

Root module for Azure networking including VNets, NSGs, and Load Balancers.

## Usage

```hcl
module "networking" {
  source = "git::https://github.com/raja1417/terraform-modules.git//azure/networking?ref=v1.0.0"

  resource_group_name = azurerm_resource_group.main.name
  location            = "East US"
  project_name        = "finsight"
  
  tags = {
    Environment = "dev"
  }
}
```
