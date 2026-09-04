resource "azurerm_storage_account" "this" {
  name                              = var.name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  min_tls_version                   = "TLS1_2"
  allow_nested_items_to_be_public   = false
  infrastructure_encryption_enabled = true

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 30
    }


    container_delete_retention_policy {
      days = 30
    }
  }


  network_rules {
    default_action             = var.network_rules.default_action
    bypass                     = var.network_rules.bypass
    ip_rules                   = var.network_rules.ip_rules
    virtual_network_subnet_ids = var.network_rules.virtual_network_subnet_ids
  }

  tags = local.common_tags

  lifecycle {
    prevent_destroy = true
  }
}


resource "azurerm_storage_container" "this" {
  for_each              = var.containers
  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = each.value.container_access_type
}


resource "azurerm_storage_management_policy" "this" {
  count              = length(var.lifecycle_rules) > 0 ? 1 : 0
  storage_account_id = azurerm_storage_account.this.id

  dynamic "rule" {
    for_each = var.lifecycle_rules

    content {
      name    = rule.key
      enabled = true

      filters {
        prefix_match = rule.value.prefix_match
        blob_types   = rule.value.blob_types
      }


      actions {
        base_blob {
          delete_after_days_since_modification_greater_than          = try(rule.value.delete_after_days, null)
          tier_to_cool_after_days_since_modification_greater_than    = try(rule.value.tier_to_cool_after_days, null)
          tier_to_archive_after_days_since_modification_greater_than = try(rule.value.tier_to_archive_after_days, null)
        }
      }
    }
  }
}
