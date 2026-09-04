locals {
  common_tags = merge(
    var.tags,
    {
      ManagedBy = "Terraform"
    }
  )
}

# Placeholder for Azure big data resources
# Add Databricks, Synapse, HDInsight as needed
