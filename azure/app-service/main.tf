resource "azurerm_service_plan" "this" {
  name                = "${var.name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.service_plan_sku
  tags                = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}


resource "azurerm_linux_web_app" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true
  app_settings        = var.app_settings

  identity {
    type = "SystemAssigned"
  }


  site_config {
    always_on           = true
    health_check_path   = var.health_check_path
    minimum_tls_version = "1.2"
    ftps_state          = "Disabled"
  }


  dynamic "connection_string" {
    for_each = nonsensitive(var.connection_strings)

    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }


  logs {
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }

  tags = local.common_tags

  lifecycle {
    ignore_changes = [
      app_settings,
    ]
  }
}


resource "azurerm_linux_web_app_slot" "this" {
  for_each       = var.slots
  name           = each.key
  app_service_id = azurerm_linux_web_app.this.id
  app_settings   = merge(var.app_settings, each.value.app_settings)
  https_only     = true

  site_config {
    always_on           = true
    minimum_tls_version = "1.2"
  }

  tags = local.common_tags
}
