resource "azurerm_databricks_workspace" "this" {
  name                                  = var.name
  resource_group_name                   = var.resource_group_name
  location                              = var.location
  sku                                   = var.sku
  managed_resource_group_name           = var.managed_resource_group_name
  public_network_access_enabled         = var.public_network_access_enabled
  network_security_group_rules_required = var.network_security_group_rules_required

  dynamic "custom_parameters" {
    for_each = try(var.custom_parameters.virtual_network_id, null) == null ? [] : [var.custom_parameters]

    content {
      virtual_network_id                                   = custom_parameters.value.virtual_network_id
      public_subnet_name                                   = try(custom_parameters.value.public_subnet_name, null)
      private_subnet_name                                  = try(custom_parameters.value.private_subnet_name, null)
      public_subnet_network_security_group_association_id  = try(custom_parameters.value.public_subnet_network_security_group_association_id, null)
      private_subnet_network_security_group_association_id = try(custom_parameters.value.private_subnet_network_security_group_association_id, null)
      no_public_ip                                         = custom_parameters.value.no_public_ip
    }
  }

  tags = local.common_tags

  lifecycle {
    prevent_destroy = true
  }
}
