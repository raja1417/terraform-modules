variable "name" {
  type = string
}


variable "billing_mode" {
  type    = string
  default = "PAY_PER_REQUEST"

  validation {
    condition = contains([
      "PAY_PER_REQUEST",
      "PROVISIONED"
    ], var.billing_mode)
    error_message = "Invalid billing_mode."
  }
}


variable "hash_key" {
  type = string
}


variable "range_key" {
  type    = string
  default = null
}


variable "attributes" {
  type = list(object({
    name = string,
    type = string
  }))

  validation {
    condition = alltrue([
      for a in var.attributes :
      contains([
        "S",
        "N",
        "B"
      ], a.type)
    ])
    error_message = "DynamoDB attributes must be S, N, or B."
  }
}


variable "read_capacity" {
  type    = number
  default = null
}


variable "write_capacity" {
  type    = number
  default = null
}


variable "stream_enabled" {
  type    = bool
  default = true
}


variable "stream_view_type" {
  type    = string
  default = "NEW_AND_OLD_IMAGES"
}


variable "ttl" {
  type = object({
    enabled        = bool,
    attribute_name = string
  })
  default = null
}


variable "global_secondary_indexes" {
  type = list(object({
    name               = string,
    hash_key           = string,
    range_key          = optional(string),
    projection_type    = optional(string, "ALL"),
    non_key_attributes = optional(list(string), []),
    read_capacity      = optional(number),
    write_capacity     = optional(number)
  }))
  default = []
}


variable "point_in_time_recovery_enabled" {
  type    = bool
  default = true
}


variable "kms_key_arn" {
  type    = string
  default = null
}


variable "tags" {
  type    = map(string)
  default = {}
}
