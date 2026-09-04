# Production Environment Variables
# Imported from shared/variables.tf + prod-specific additions

variable "instance_type" {
  description = "EC2 instance type for prod environment"
  type        = string
  default     = "t3.medium"
}

variable "kubernetes_version" {
  description = "EKS/AKS Kubernetes version"
  type        = string
  default     = "1.27"
}

variable "enable_monitoring" {
  description = "Enable CloudWatch/Azure Monitor"
  type        = bool
  default     = true
}

variable "rds_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
  default     = 200
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.large"
}

variable "enable_backup" {
  description = "Enable automated backups for production"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "RDS backup retention period"
  type        = number
  default     = 30
}
