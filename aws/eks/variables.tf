variable "name" {
  type = string
}


variable "cluster_role_arn" {
  type = string
}


variable "node_role_arn" {
  type = string
}


variable "subnet_ids" {
  type = list(string)
}


variable "security_group_ids" {
  type    = list(string)
  default = []
}


variable "kubernetes_version" {
  type    = string
  default = null
}


variable "endpoint_private_access" {
  type    = bool
  default = true
}


variable "endpoint_public_access" {
  type    = bool
  default = false
}


variable "enabled_cluster_log_types" {
  type = list(string)
  default = [
    "api",
    "audit",
    "authenticator",
  ]
}


variable "kms_key_arn" {
  type    = string
  default = null
}


variable "node_groups" {
  type = map(object({
    subnet_ids = optional(list(string)),
    instance_types = optional(list(string), [
      "t3.medium"
    ]),
    capacity_type = optional(string, "ON_DEMAND"),
    desired_size  = number,
    min_size      = number,
    max_size      = number,
    disk_size     = optional(number, 50),
    labels        = optional(map(string), {}),
    taints = optional(list(object({
      key    = string,
      value  = optional(string),
      effect = string
    })), [])
  }))
  default = {}
}


variable "addons" {
  type = map(object({
    version                     = optional(string),
    resolve_conflicts_on_create = optional(string, "OVERWRITE"),
    resolve_conflicts_on_update = optional(string, "OVERWRITE"),
    configuration_values        = optional(string)
  }))
  default = {}
}


variable "tags" {
  type    = map(string)
  default = {}
}
