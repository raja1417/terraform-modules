variable "name" {
  type = string
}


variable "release_label" {
  type    = string
  default = "emr-6.15.0"
}


variable "applications" {
  type = list(string)
  default = [
    "Spark",
    "Hadoop",
  ]
}


variable "service_role" {
  type = string
}


variable "job_flow_role" {
  type = string
}


variable "subnet_id" {
  type = string
}


variable "log_uri" {
  type    = string
  default = null
}


variable "master_instance_type" {
  type    = string
  default = "m5.xlarge"
}


variable "core_instance_type" {
  type    = string
  default = "m5.xlarge"
}


variable "core_instance_count" {
  type    = number
  default = 2
}


variable "keep_job_flow_alive_when_no_steps" {
  type    = bool
  default = true
}


variable "termination_protection" {
  type    = bool
  default = true
}


variable "bootstrap_actions" {
  type = list(object({
    name = string,
    path = string,
    args = optional(list(string), [])
  }))
  default = []
}


variable "steps" {
  type = list(object({
    name              = string,
    action_on_failure = optional(string, "CONTINUE"),
    hadoop_jar_step = object({
      jar        = string,
      main_class = optional(string),
      args       = optional(list(string), [])
    })
  }))
  default = []
}


variable "managed_scaling_policy" {
  type = object({
    unit_type                       = optional(string, "Instances"),
    minimum_capacity_units          = number,
    maximum_capacity_units          = number,
    maximum_ondemand_capacity_units = optional(number),
    maximum_core_capacity_units     = optional(number)
  })
  default = null
}


variable "tags" {
  type    = map(string)
  default = {}
}
