variable "name" {
  type = string

  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 63
    error_message = "S3 bucket name must be 3-63 characters."
  }
}


variable "force_destroy" {
  type    = bool
  default = false
}


variable "kms_key_id" {
  type    = string
  default = null
}


variable "versioning_status" {
  type    = string
  default = "Enabled"

  validation {
    condition = contains([
      "Enabled",
      "Suspended",
      "Disabled"
    ], var.versioning_status)
    error_message = "versioning_status must be Enabled, Suspended, or Disabled."
  }
}


variable "block_public_access" {
  type    = bool
  default = true
}


variable "lifecycle_rules" {
  type = list(object({
    id                                 = string,
    enabled                            = optional(bool, true),
    prefix                             = optional(string),
    expiration_days                    = optional(number),
    noncurrent_version_expiration_days = optional(number),
    transitions = optional(list(object({
      days          = number,
      storage_class = string
    })), [])
  }))
  default = []
}


variable "logging" {
  type = object({
    target_bucket = string,
    target_prefix = optional(string, "")
  })
  default = null
}


variable "tags" {
  type    = map(string)
  default = {}
}
