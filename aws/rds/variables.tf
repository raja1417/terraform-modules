variable "name" {
  type = string
}


variable "engine" {
  type    = string
  default = "postgres"
}


variable "engine_version" {
  type    = string
  default = null
}


variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}


variable "allocated_storage" {
  type    = number
  default = 20

  validation {
    condition     = var.allocated_storage >= 20
    error_message = "allocated_storage must be at least 20."
  }
}


variable "max_allocated_storage" {
  type    = number
  default = 100
}


variable "db_name" {
  type    = string
  default = null
}


variable "username" {
  type      = string
  sensitive = true
}


variable "password" {
  type      = string
  sensitive = true
  default   = null
}


variable "manage_master_user_password" {
  type    = bool
  default = true
}


variable "subnet_ids" {
  type    = list(string)
  default = []
}


variable "vpc_security_group_ids" {
  type    = list(string)
  default = []
}


variable "backup_retention_period" {
  type    = number
  default = 7

  validation {
    condition     = var.backup_retention_period >= 1
    error_message = "Backups must be retained for at least one day."
  }
}


variable "multi_az" {
  type    = bool
  default = true
}


variable "storage_encrypted" {
  type    = bool
  default = true
}


variable "kms_key_id" {
  type    = string
  default = null
}


variable "deletion_protection" {
  type    = bool
  default = true
}


variable "skip_final_snapshot" {
  type    = bool
  default = false
}


variable "monitoring_interval" {
  type    = number
  default = 60
}


variable "monitoring_role_arn" {
  type    = string
  default = null
}


variable "performance_insights_enabled" {
  type    = bool
  default = true
}


variable "enabled_cloudwatch_logs_exports" {
  type    = list(string)
  default = []
}


variable "tags" {
  type    = map(string)
  default = {}
}
