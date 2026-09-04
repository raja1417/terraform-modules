# Shared Variables for All Environments
# These variables are inherited by dev, test, and prod environments

variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, prod."
  }
}

variable "region" {
  description = "AWS/Azure region for resources"
  type        = string
}

variable "cloud_provider" {
  description = "Cloud provider (aws or azure)"
  type        = string
  validation {
    condition     = contains(["aws", "azure"], var.cloud_provider)
    error_message = "Cloud provider must be either 'aws' or 'azure'."
  }
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Repository = "terraform-modules"
  }
}
