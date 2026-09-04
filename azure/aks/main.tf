resource "azurerm_kubernetes_cluster" "this" {
  name                    = var.name
  resource_group_name     = var.resource_group_name
  location                = var.location
  dns_prefix              = var.dns_prefix
  kubernetes_version      = var.kubernetes_version
  private_cluster_enabled = var.private_cluster_enabled
  azure_policy_enabled    = var.azure_policy_enabled

  default_node_pool {
    name                = var.default_node_pool.name
    vm_size             = var.default_node_pool.vm_size
    node_count          = var.default_node_pool.node_count
    min_count           = var.default_node_pool.min_count
    max_count           = var.default_node_pool.max_count
    enable_auto_scaling = true
    vnet_subnet_id      = try(var.default_node_pool.vnet_subnet_id, null)
  }


  identity {
    type = "SystemAssigned"
  }


  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id == null ? [] : [var.log_analytics_workspace_id]

    content {
      log_analytics_workspace_id = oms_agent.value
    }
  }


  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  tags = local.common_tags

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count,
    ]
  }
}


resource "azurerm_kubernetes_cluster_node_pool" "this" {
  for_each              = var.node_pools
  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = each.value.vm_size
  node_count            = try(each.value.node_count, null)
  min_count             = try(each.value.min_count, null)
  max_count             = try(each.value.max_count, null)
  enable_auto_scaling   = try(each.value.min_count, null) != null
  mode                  = each.value.mode
  vnet_subnet_id        = try(each.value.vnet_subnet_id, null)
  node_labels           = each.value.node_labels
  node_taints           = each.value.node_taints
  tags                  = local.common_tags

  lifecycle {
    ignore_changes = [
      node_count,
    ]
  }
}
