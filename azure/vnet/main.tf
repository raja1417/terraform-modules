resource "azurerm_virtual_network" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}


resource "azurerm_subnet" "this" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints

  dynamic "delegation" {
    for_each = each.value.delegations

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation_name
        actions = delegation.value.actions
      }
    }
  }
}


resource "azurerm_route_table" "this" {
  for_each            = var.route_tables
  name                = "${var.name}-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.common_tags

  dynamic "route" {
    for_each = each.value.routes

    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = try(route.value.next_hop_in_ip_address, null)
    }
  }
}


resource "azurerm_subnet_route_table_association" "this" {
  for_each = merge([
    for rt_key, rt in var.route_tables :
    {
      for subnet_key in rt.subnet_keys :
      "${rt_key}-${subnet_key}" => {
        route_table_key = rt_key,
        subnet_key      = subnet_key
      }
    }
  ]...)
  subnet_id      = azurerm_subnet.this[each.value.subnet_key].id
  route_table_id = azurerm_route_table.this[each.value.route_table_key].id
}
