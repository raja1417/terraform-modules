variable "name" {
  type = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "Storage account names must be 3-24 lowercase alphanumeric characters."
  }
}


variable "resource_group_name" {
  type = string
}


variable "location" {
  type = string
}


variable "account_tier" {
  type    = string
  default = "Standard"
}


variable "account_replication_type" {
  type    = string
  default = "ZRS"
}


variable "containers" {
  type = map(object({
    container_access_type = optional(string, "private")
  }))
  default = {}
}


variable "network_rules" {
  type = object({
    default_action = optional(string, "Deny"),
    bypass = optional(list(string), [
      "AzureServices"
    ]),
    ip_rules                   = optional(list(string), []),
    virtual_network_subnet_ids = optional(list(string), [])
  })
  default = {}
}


variable "lifecycle_rules" {
  type = map(object({
    prefix_match = optional(list(string), []),
    blob_types = optional(list(string), [
      "blockBlob"
    ]),
    delete_after_days          = optional(number),
    tier_to_cool_after_days    = optional(number),
    tier_to_archive_after_days = optional(number)
  }))
  default = {}
}


variable "tags" {
  type    = map(string)
  default = {}
}
