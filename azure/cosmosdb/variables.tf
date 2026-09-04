variable "name" {
  type = string
}


variable "resource_group_name" {
  type = string
}


variable "location" {
  type = string
}


variable "kind" {
  type    = string
  default = "GlobalDocumentDB"
}


variable "offer_type" {
  type    = string
  default = "Standard"
}


variable "consistency_level" {
  type    = string
  default = "Session"
}


variable "locations" {
  type = list(object({
    location          = string,
    failover_priority = number,
    zone_redundant    = optional(bool, true)
  }))
  default = []
}


variable "databases" {
  type = map(object({
    throughput = optional(number),
    containers = optional(map(object({
      partition_key_path = string,
      throughput         = optional(number),
      default_ttl        = optional(number),
      indexing_mode      = optional(string, "consistent"),
      included_paths = optional(list(string), [
        "/*"
      ]),
      excluded_paths = optional(list(string), []),
      unique_keys    = optional(list(list(string)), [])
    })), {})
  }))
  default = {}
}


variable "capabilities" {
  type    = list(string)
  default = []
}


variable "backup" {
  type = object({
    type                = optional(string, "Periodic"),
    interval_in_minutes = optional(number, 240),
    retention_in_hours  = optional(number, 8)
  })
  default = {}
}


variable "tags" {
  type    = map(string)
  default = {}
}
