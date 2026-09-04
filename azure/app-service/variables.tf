variable "name" {
  type = string
}


variable "resource_group_name" {
  type = string
}


variable "location" {
  type = string
}


variable "service_plan_sku" {
  type    = string
  default = "P1v3"
}


variable "app_settings" {
  type      = map(string)
  default   = {}
  sensitive = true
}


variable "connection_strings" {
  type = list(object({
    name  = string,
    type  = string,
    value = string
  }))
  default   = []
  sensitive = true
}


variable "health_check_path" {
  type    = string
  default = "/health"
}


variable "slots" {
  type = map(object({
    app_settings = optional(map(string), {})
  }))
  default = {}
}


variable "tags" {
  type    = map(string)
  default = {}
}
