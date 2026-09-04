# Azure Compute Module

Root module for Azure compute resources including VMs, VMSS, and App Service.

## Usage

```hcl
module "compute" {
  source = "git::https://github.com/raja1417/terraform-modules.git//azure/compute?ref=v1.0.0"

  resource_group_name = azurerm_resource_group.main.name
  location            = "East US"
  project_name        = "finsight"
  environment         = "dev"
  
  tags = {
    Environment = "dev"
  }
}
```
