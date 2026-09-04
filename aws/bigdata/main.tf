# Placeholder for big data resources
# Add Glue, EMR, Redshift, Athena resources as needed

locals {
  common_tags = merge(
    var.tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}
