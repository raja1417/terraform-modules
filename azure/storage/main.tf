locals {
  common_tags = merge(
    var.tags,
    {
      ManagedBy = "Terraform"
    }
  )
}

# Placeholder for Azure storage resources
# Add Blob Storage, SQL Database, CosmosDB as needed
