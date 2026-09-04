# Azure Kubernetes Module

Root module for Azure Kubernetes Service (AKS).

## Usage

```hcl
module "kubernetes" {
  source = "git::https://github.com/raja1417/terraform-modules.git//azure/kubernetes?ref=v1.0.0"

  resource_group_name = azurerm_resource_group.main.name
  location            = "East US"
  cluster_name        = "finsight-dev-aks"
  kubernetes_version  = "1.27"
  
  tags = {
    Environment = "dev"
  }
}
```
