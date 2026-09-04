variable "name" {
  type = string
}


variable "resource_group_name" {
  type = string
}


variable "location" {
  type = string
}


variable "sku" {
  type    = string
  default = "premium"
}


variable "managed_resource_group_name" {
  type    = string
  default = null
}


variable "public_network_access_enabled" {
  type    = bool
  default = false
}


variable "network_security_group_rules_required" {
  type    = string
  default = "NoAzureDatabricksRules"
}


variable "custom_parameters" {
  type = object({
    virtual_network_id                                   = optional(string),
    public_subnet_name                                   = optional(string),
    private_subnet_name                                  = optional(string),
    public_subnet_network_security_group_association_id  = optional(string),
    private_subnet_network_security_group_association_id = optional(string),
    no_public_ip                                         = optional(bool, true)
  })
  default = {}
}


variable "tags" {
  type    = map(string)
  default = {}
}
