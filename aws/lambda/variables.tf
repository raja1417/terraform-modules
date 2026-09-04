variable "name" {
  type = string
}


variable "description" {
  type    = string
  default = null
}


variable "runtime" {
  type = string
}


variable "handler" {
  type = string
}


variable "role_arn" {
  type = string
}


variable "filename" {
  type    = string
  default = null
}


variable "s3_bucket" {
  type    = string
  default = null
}


variable "s3_key" {
  type    = string
  default = null
}


variable "source_code_hash" {
  type    = string
  default = null
}


variable "memory_size" {
  type    = number
  default = 256

  validation {
    condition     = var.memory_size >= 128 && var.memory_size <= 10240
    error_message = "memory_size must be 128-10240."
  }
}


variable "timeout" {
  type    = number
  default = 30

  validation {
    condition     = var.timeout >= 1 && var.timeout <= 900
    error_message = "timeout must be 1-900."
  }
}


variable "environment_variables" {
  type      = map(string)
  default   = {}
  sensitive = true
}


variable "layers" {
  type    = list(string)
  default = []
}


variable "subnet_ids" {
  type    = list(string)
  default = []
}


variable "security_group_ids" {
  type    = list(string)
  default = []
}


variable "kms_key_arn" {
  type    = string
  default = null
}


variable "dead_letter_target_arn" {
  type    = string
  default = null
}


variable "tracing_mode" {
  type    = string
  default = "Active"
}


variable "reserved_concurrent_executions" {
  type    = number
  default = -1
}


variable "publish" {
  type    = bool
  default = true
}


variable "aliases" {
  type = map(object({
    function_version = string,
    description      = optional(string)
  }))
  default = {}
}


variable "event_source_mappings" {
  type = map(object({
    event_source_arn  = string,
    batch_size        = optional(number, 10),
    enabled           = optional(bool, true),
    starting_position = optional(string)
  }))
  default = {}
}


variable "tags" {
  type    = map(string)
  default = {}
}
