variable "name" {
  type = string
}


variable "server_name" {
  type = string
}


variable "resource_group_name" {
  type = string
}


variable "location" {
  type = string
}


variable "administrator_login" {
  type      = string
  sensitive = true
}


variable "administrator_password" {
  type      = string
  sensitive = true
}


variable "sku_name" {
  type    = string
  default = "GP_S_Gen5_2"
}


variable "max_size_gb" {
  type    = number
  default = 32
}


variable "zone_redundant" {
  type    = bool
  default = true
}


variable "firewall_rules" {
  type = map(object({
    start_ip_address = string,
    end_ip_address   = string
  }))
  default = {}
}


variable "short_term_retention_days" {
  type    = number
  default = 14
}


variable "long_term_retention" {
  type = object({
    weekly_retention  = optional(string, "P4W"),
    monthly_retention = optional(string, "P12M"),
    yearly_retention  = optional(string, "P5Y"),
    week_of_year      = optional(number, 1)
  })
  default = {}
}


variable "tags" {
  type    = map(string)
  default = {}
}
