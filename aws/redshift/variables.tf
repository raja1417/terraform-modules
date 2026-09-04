variable "name" {
  type = string
}


variable "database_name" {
  type = string
}


variable "master_username" {
  type      = string
  sensitive = true
}


variable "master_password" {
  type      = string
  sensitive = true
}


variable "node_type" {
  type    = string
  default = "ra3.xlplus"
}


variable "cluster_type" {
  type    = string
  default = "multi-node"
}


variable "number_of_nodes" {
  type    = number
  default = 2
}


variable "subnet_ids" {
  type    = list(string)
  default = []
}


variable "vpc_security_group_ids" {
  type    = list(string)
  default = []
}


variable "encrypted" {
  type    = bool
  default = true
}


variable "kms_key_id" {
  type    = string
  default = null
}


variable "publicly_accessible" {
  type    = bool
  default = false
}


variable "skip_final_snapshot" {
  type    = bool
  default = false
}


variable "automated_snapshot_retention_period" {
  type    = number
  default = 7
}


variable "parameters" {
  type    = map(string)
  default = {}
}


variable "parameter_group_family" {
  description = "Redshift parameter group family to use when parameters are provided."
  type        = string
  default     = "redshift-1.0"
}


variable "tags" {
  type    = map(string)
  default = {}
}
