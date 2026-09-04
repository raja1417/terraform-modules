variable "name" {
  type = string
}


variable "resource_group_name" {
  type = string
}


variable "location" {
  type = string
}


variable "address_space" {
  type = list(string)

  validation {
    condition     = length(var.address_space) > 0
    error_message = "address_space is required."
  }
}


variable "dns_servers" {
  type    = list(string)
  default = []
}


variable "subnets" {
  type = map(object({
    address_prefixes  = list(string),
    service_endpoints = optional(list(string), []),
    delegations = optional(list(object({
      name                    = string,
      service_delegation_name = string,
      actions                 = optional(list(string), [])
    })), [])
  }))
  default = {}
}


variable "route_tables" {
  type = map(object({
    routes = list(object({
      name                   = string,
      address_prefix         = string,
      next_hop_type          = string,
      next_hop_in_ip_address = optional(string)
    })),
    subnet_keys = optional(list(string), [])
  }))
  default = {}
}


variable "tags" {
  type    = map(string)
  default = {}
}
