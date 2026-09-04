locals {
  cosmos_locations = length(var.locations) == 0 ? [{ location = var.location, failover_priority = 0, zone_redundant = true }] : var.locations
  containers = merge([
    for db_key, db in var.databases :
    {
      for c_key, c in db.containers :
      "${db_key}/${c_key}" => merge(c, {
        database = db_key,
        name     = c_key
      })
    }
  ]...)
}


resource "azurerm_cosmosdb_account" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  offer_type                    = var.offer_type
  kind                          = var.kind
  automatic_failover_enabled    = true
  public_network_access_enabled = false

  consistency_policy {
    consistency_level = var.consistency_level
  }


  dynamic "geo_location" {
    for_each = local.cosmos_locations

    content {
      location          = geo_location.value.location
      failover_priority = geo_location.value.failover_priority
      zone_redundant    = geo_location.value.zone_redundant
    }
  }


  dynamic "capabilities" {
    for_each = toset(var.capabilities)

    content {
      name = capabilities.value
    }
  }


  backup {
    type                = var.backup.type
    interval_in_minutes = var.backup.interval_in_minutes
    retention_in_hours  = var.backup.retention_in_hours
  }

  tags = local.common_tags

  lifecycle {
    prevent_destroy = true
  }
}


resource "azurerm_cosmosdb_sql_database" "this" {
  for_each            = var.databases
  name                = each.key
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  throughput          = try(each.value.throughput, null)
}


resource "azurerm_cosmosdb_sql_container" "this" {
  for_each            = local.containers
  name                = each.value.name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  database_name       = azurerm_cosmosdb_sql_database.this[each.value.database].name
  partition_key_path  = each.value.partition_key_path
  throughput          = try(each.value.throughput, null)
  default_ttl         = try(each.value.default_ttl, null)

  indexing_policy {
    indexing_mode = each.value.indexing_mode

    dynamic "included_path" {
      for_each = each.value.included_paths

      content {
        path = included_path.value
      }
    }


    dynamic "excluded_path" {
      for_each = each.value.excluded_paths

      content {
        path = excluded_path.value
      }
    }
  }


  dynamic "unique_key" {
    for_each = each.value.unique_keys

    content {
      paths = unique_key.value
    }
  }
}
