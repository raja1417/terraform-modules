variable "name" {
  type = string
}


variable "resource_group_name" {
  type = string
}


variable "location" {
  type = string
}


variable "dns_prefix" {
  type = string
}


variable "kubernetes_version" {
  type    = string
  default = null
}


variable "default_node_pool" {
  type = object({
    name           = optional(string, "system"),
    vm_size        = optional(string, "Standard_D2s_v5"),
    node_count     = optional(number, 2),
    min_count      = optional(number, 1),
    max_count      = optional(number, 5),
    vnet_subnet_id = optional(string)
  })
  default = {}
}


variable "node_pools" {
  type = map(object({
    vm_size        = string,
    node_count     = optional(number),
    min_count      = optional(number),
    max_count      = optional(number),
    mode           = optional(string, "User"),
    vnet_subnet_id = optional(string),
    node_labels    = optional(map(string), {}),
    node_taints    = optional(list(string), [])
  }))
  default = {}
}


variable "log_analytics_workspace_id" {
  type    = string
  default = null
}


variable "azure_policy_enabled" {
  type    = bool
  default = true
}


variable "private_cluster_enabled" {
  type    = bool
  default = true
}


variable "tags" {
  type    = map(string)
  default = {}
}
