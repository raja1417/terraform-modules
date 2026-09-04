locals {
  common_tags = merge(
    var.tags,
    {
      ManagedBy = "Terraform"
    }
  )
}

# Placeholder for Azure networking resources
# Add VNets, NSGs, Load Balancers as needed
