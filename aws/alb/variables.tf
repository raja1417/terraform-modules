variable "name" {
  type = string

  validation {
    condition     = length(var.name) <= 32
    error_message = "ALB name must be 32 characters or fewer."
  }
}


variable "internal" {
  type    = bool
  default = false
}


variable "load_balancer_type" {
  type    = string
  default = "application"
}


variable "security_group_ids" {
  type    = list(string)
  default = []
}


variable "subnet_ids" {
  type = list(string)

  validation {
    condition     = length(var.subnet_ids) > 0
    error_message = "At least one subnet is required."
  }
}


variable "enable_deletion_protection" {
  type    = bool
  default = true
}


variable "access_logs" {
  type = object({
    bucket  = string,
    prefix  = optional(string),
    enabled = optional(bool, true)
  })
  default = null
}


variable "target_groups" {
  type = map(object({
    port        = number,
    protocol    = optional(string, "HTTP"),
    vpc_id      = string,
    target_type = optional(string, "instance"),
    health_check = optional(object({
      path                = optional(string, "/"),
      matcher             = optional(string, "200-399"),
      interval            = optional(number, 30),
      timeout             = optional(number, 5),
      healthy_threshold   = optional(number, 3),
      unhealthy_threshold = optional(number, 3)
    }))
  }))
  default = {}
}


variable "listeners" {
  type = map(object({
    port             = number,
    protocol         = string,
    certificate_arn  = optional(string),
    ssl_policy       = optional(string, "ELBSecurityPolicy-TLS13-1-2-2021-06"),
    target_group_key = string
  }))
  default = {}
}


variable "tags" {
  type    = map(string)
  default = {}
}
