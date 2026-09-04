resource "azurerm_synapse_workspace" "this" {
  name                                 = var.name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = var.storage_data_lake_gen2_filesystem_id
  sql_administrator_login              = var.sql_administrator_login
  sql_administrator_login_password     = var.sql_administrator_login_password
  managed_virtual_network_enabled      = var.managed_virtual_network_enabled

  identity {
    type = "SystemAssigned"
  }

  tags = local.common_tags

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      sql_administrator_login_password,
    ]
  }
}


resource "azurerm_synapse_firewall_rule" "this" {
  for_each             = var.firewall_rules
  name                 = each.key
  synapse_workspace_id = azurerm_synapse_workspace.this.id
  start_ip_address     = each.value.start_ip_address
  end_ip_address       = each.value.end_ip_address
}


resource "azurerm_synapse_sql_pool" "this" {
  for_each             = var.sql_pools
  name                 = each.key
  synapse_workspace_id = azurerm_synapse_workspace.this.id
  sku_name             = each.value.sku_name
  create_mode          = each.value.create_mode
  tags                 = local.common_tags

  lifecycle {
    prevent_destroy = true
  }
}


resource "azurerm_synapse_spark_pool" "this" {
  for_each             = var.spark_pools
  name                 = each.key
  synapse_workspace_id = azurerm_synapse_workspace.this.id
  node_size_family     = each.value.node_size_family
  node_size            = each.value.node_size

  auto_scale {
    min_node_count = each.value.min_node_count
    max_node_count = each.value.max_node_count
  }


  auto_pause {
    delay_in_minutes = 15
  }

  tags = local.common_tags
}
