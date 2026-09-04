resource "aws_glue_security_configuration" "this" {
  count = var.security_configuration == null ? 0 : 1
  name  = "${var.name}-security"

  encryption_configuration {
    s3_encryption {
      s3_encryption_mode = try(var.security_configuration.kms_key_arn, null) == null ? "SSE-S3" : "SSE-KMS"
      kms_key_arn        = try(var.security_configuration.kms_key_arn, null)
    }


    cloudwatch_encryption {
      cloudwatch_encryption_mode = try(var.security_configuration.cloudwatch_kms_key_arn, null) == null ? "DISABLED" : "SSE-KMS"
      kms_key_arn                = try(var.security_configuration.cloudwatch_kms_key_arn, null)
    }

    job_bookmarks_encryption {
      job_bookmarks_encryption_mode = try(var.security_configuration.kms_key_arn, null) == null ? "DISABLED" : "CSE-KMS"
      kms_key_arn                   = try(var.security_configuration.kms_key_arn, null)
    }
  }
}


resource "aws_glue_catalog_database" "this" {
  for_each     = var.catalog_databases
  name         = each.key
  description  = try(each.value.description, null)
  location_uri = try(each.value.location_uri, null)
}


resource "aws_glue_job" "this" {
  for_each               = var.jobs
  name                   = each.key
  role_arn               = each.value.role_arn
  glue_version           = each.value.glue_version
  worker_type            = each.value.worker_type
  number_of_workers      = each.value.number_of_workers
  timeout                = each.value.timeout
  security_configuration = try(aws_glue_security_configuration.this[0].name, null)

  command {
    name            = each.value.command_name
    script_location = each.value.script_location
    python_version  = each.value.python_version
  }

  default_arguments = merge({
    "--enable-metrics"                   = "true",
    "--enable-continuous-cloudwatch-log" = "true"
  }, each.value.default_arguments)
  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_glue_crawler" "this" {
  for_each      = var.crawlers
  name          = each.key
  role          = each.value.role_arn
  database_name = each.value.database_name
  schedule      = try(each.value.schedule, null)

  dynamic "s3_target" {
    for_each = each.value.s3_targets

    content {
      path = s3_target.value
    }
  }

  tags = local.common_tags
}
