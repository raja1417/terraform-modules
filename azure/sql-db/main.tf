resource "azurerm_mssql_server" "this" {
  name                          = var.server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12.0"
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_password
  minimum_tls_version           = "1.2"
  public_network_access_enabled = length(var.firewall_rules) > 0

  identity {
    type = "SystemAssigned"
  }

  tags = local.common_tags

  lifecycle {
    ignore_changes = [
      administrator_login_password,
    ]
  }
}


resource "azurerm_mssql_firewall_rule" "this" {
  for_each         = var.firewall_rules
  name             = each.key
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}


resource "azurerm_mssql_database" "this" {
  name                                = var.name
  server_id                           = azurerm_mssql_server.this.id
  sku_name                            = var.sku_name
  max_size_gb                         = var.max_size_gb
  zone_redundant                      = var.zone_redundant
  transparent_data_encryption_enabled = true

  short_term_retention_policy {
    retention_days = var.short_term_retention_days
  }


  long_term_retention_policy {
    weekly_retention  = var.long_term_retention.weekly_retention
    monthly_retention = var.long_term_retention.monthly_retention
    yearly_retention  = var.long_term_retention.yearly_retention
    week_of_year      = var.long_term_retention.week_of_year
  }

  tags = local.common_tags

  lifecycle {
    prevent_destroy = true
  }
}
