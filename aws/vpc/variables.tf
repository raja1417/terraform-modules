variable "name" {
  type = string
}


variable "cidr_block" {
  type = string

  validation {
    condition     = can(cidrnetmask(var.cidr_block))
    error_message = "cidr_block must be valid CIDR."
  }
}


variable "enable_dns_support" {
  type    = bool
  default = true
}


variable "enable_dns_hostnames" {
  type    = bool
  default = true
}


variable "subnets" {
  type = map(object({
    cidr_block              = string,
    availability_zone       = optional(string),
    public                  = optional(bool, false),
    map_public_ip_on_launch = optional(bool, false),
    tags                    = optional(map(string), {})
  }))
  default = {}
}


variable "create_nat_gateway" {
  type    = bool
  default = false
}


variable "single_nat_gateway" {
  type    = bool
  default = true
}


variable "tags" {
  type    = map(string)
  default = {}
}
