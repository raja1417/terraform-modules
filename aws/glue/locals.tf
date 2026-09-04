locals {
  common_tags = merge(var.tags, {
    ManagedBy = "Terraform",
    Module    = var.name
  })

  glue_kms_key_arn            = try(var.security_configuration.kms_key_arn, null)
  glue_cloudwatch_kms_key_arn = try(var.security_configuration.cloudwatch_kms_key_arn, null)
}
