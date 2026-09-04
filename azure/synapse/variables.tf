variable "name" {
  type = string
}


variable "resource_group_name" {
  type = string
}


variable "location" {
  type = string
}


variable "storage_data_lake_gen2_filesystem_id" {
  type = string
}


variable "sql_administrator_login" {
  type      = string
  sensitive = true
}


variable "sql_administrator_login_password" {
  type      = string
  sensitive = true
}


variable "managed_virtual_network_enabled" {
  type    = bool
  default = true
}


variable "firewall_rules" {
  type = map(object({
    start_ip_address = string,
    end_ip_address   = string
  }))
  default = {}
}


variable "sql_pools" {
  type = map(object({
    sku_name    = optional(string, "DW100c"),
    create_mode = optional(string, "Default")
  }))
  default = {}
}


variable "spark_pools" {
  type = map(object({
    node_size_family = optional(string, "MemoryOptimized"),
    node_size        = optional(string, "Small"),
    min_node_count   = optional(number, 3),
    max_node_count   = optional(number, 10)
  }))
  default = {}
}


variable "tags" {
  type    = map(string)
  default = {}
}
