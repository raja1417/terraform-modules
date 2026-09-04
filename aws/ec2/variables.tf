variable "name" {
  type = string

  validation {
    condition     = length(var.name) > 0
    error_message = "name is required."
  }
}


variable "ami_id" {
  type = string

  validation {
    condition     = can(regex("^ami-", var.ami_id))
    error_message = "ami_id must be an AMI id."
  }
}


variable "instance_type" {
  type    = string
  default = "t3.micro"
}


variable "subnet_id" {
  type    = string
  default = null
}


variable "security_group_ids" {
  type    = list(string)
  default = []
}


variable "iam_instance_profile" {
  type    = string
  default = null
}


variable "key_name" {
  type    = string
  default = null
}


variable "user_data" {
  type      = string
  default   = null
  sensitive = true
}


variable "associate_public_ip_address" {
  type    = bool
  default = false
}


variable "monitoring" {
  type    = bool
  default = true
}


variable "disable_api_termination" {
  type    = bool
  default = true
}


variable "create_eip" {
  type    = bool
  default = false
}


variable "metadata_options" {
  type = object({
    http_endpoint               = optional(string, "enabled"),
    http_tokens                 = optional(string, "required"),
    http_put_response_hop_limit = optional(number, 1),
    instance_metadata_tags      = optional(string, "disabled")
  })
  default = {}
}


variable "root_block_device" {
  type = object({
    volume_type           = optional(string, "gp3"),
    volume_size           = optional(number, 20),
    encrypted             = optional(bool, true),
    kms_key_id            = optional(string),
    delete_on_termination = optional(bool, true),
    iops                  = optional(number),
    throughput            = optional(number)
  })
  default = {}
}


variable "ebs_block_devices" {
  type = list(object({
    device_name           = string,
    volume_type           = optional(string, "gp3"),
    volume_size           = number,
    encrypted             = optional(bool, true),
    kms_key_id            = optional(string),
    delete_on_termination = optional(bool, true),
    iops                  = optional(number),
    throughput            = optional(number)
  }))
  default = []

  validation {
    condition = alltrue([
      for d in var.ebs_block_devices :
      d.volume_size > 0
    ])
    error_message = "All EBS volumes must be larger than zero."
  }
}


variable "tags" {
  type    = map(string)
  default = {}
}
