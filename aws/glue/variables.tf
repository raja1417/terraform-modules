variable "name" {
  type = string
}


variable "catalog_databases" {
  type = map(object({
    description  = optional(string),
    location_uri = optional(string)
  }))
  default = {}
}


variable "security_configuration" {
  type = object({
    kms_key_arn            = optional(string),
    cloudwatch_kms_key_arn = optional(string)
  })
  default = null
}


variable "jobs" {
  type = map(object({
    role_arn          = string,
    command_name      = optional(string, "glueetl"),
    script_location   = string,
    python_version    = optional(string, "3"),
    glue_version      = optional(string, "4.0"),
    worker_type       = optional(string, "G.1X"),
    number_of_workers = optional(number, 2),
    timeout           = optional(number, 2880),
    default_arguments = optional(map(string), {})
  }))
  default = {}
}


variable "crawlers" {
  type = map(object({
    role_arn      = string,
    database_name = string,
    s3_targets    = list(string),
    schedule      = optional(string)
  }))
  default = {}
}


variable "tags" {
  type    = map(string)
  default = {}
}
