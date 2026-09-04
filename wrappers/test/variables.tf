# Test Environment Variables
# Imported from shared/variables.tf + test-specific additions

variable "instance_type" {
  description = "EC2 instance type for test environment"
  type        = string
  default     = "t3.small"
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
  default     = 50
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.small"
}
