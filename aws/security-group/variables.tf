variable "name" {
  type = string

  validation {
    condition     = length(var.name) > 0
    error_message = "name is required."
  }
}


variable "description" {
  type    = string
  default = "Managed security group"
}


variable "vpc_id" {
  type = string

  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "vpc_id is required."
  }
}


variable "revoke_rules_on_delete" {
  type    = bool
  default = true
}


variable "ingress_rules" {
  type = list(object({
    description      = optional(string),
    from_port        = number,
    to_port          = number,
    protocol         = string,
    cidr_blocks      = optional(list(string), []),
    ipv6_cidr_blocks = optional(list(string), []),
    prefix_list_ids  = optional(list(string), []),
    security_groups  = optional(list(string), []),
    self             = optional(bool, false)
  }))
  default = []
}


variable "egress_rules" {
  type = list(object({
    description      = optional(string),
    from_port        = number,
    to_port          = number,
    protocol         = string,
    cidr_blocks      = optional(list(string), []),
    ipv6_cidr_blocks = optional(list(string), []),
    prefix_list_ids  = optional(list(string), []),
    security_groups  = optional(list(string), []),
    self             = optional(bool, false)
  }))
  default = [
    {
      from_port = 0,
      to_port   = 0,
      protocol  = "-1",
      cidr_blocks = [
        "0.0.0.0/0",
      ],
    },
  ]
}


variable "tags" {
  type    = map(string)
  default = {}
}
