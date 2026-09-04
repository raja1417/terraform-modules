resource "aws_lambda_function" "this" {
  function_name                  = var.name
  description                    = var.description
  role                           = var.role_arn
  runtime                        = var.runtime
  handler                        = var.handler
  filename                       = var.filename
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  source_code_hash               = var.source_code_hash
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  layers                         = var.layers
  kms_key_arn                    = var.kms_key_arn
  reserved_concurrent_executions = var.reserved_concurrent_executions
  publish                        = var.publish
  tags                           = local.common_tags

  dynamic "environment" {
    for_each = length(nonsensitive(var.environment_variables)) == 0 ? [] : [true]

    content {
      variables = var.environment_variables
    }
  }


  dynamic "vpc_config" {
    for_each = length(var.subnet_ids) == 0 ? {} : { vpc = true }

    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }


  dynamic "dead_letter_config" {
    for_each = var.dead_letter_target_arn == null ? {} : { dead_letter = var.dead_letter_target_arn }

    content {
      target_arn = dead_letter_config.value
    }
  }


  tracing_config {
    mode = var.tracing_mode
  }


  lifecycle {
    create_before_destroy = true

    precondition {
      condition     = (var.filename != null) != (var.s3_bucket != null && var.s3_key != null)
      error_message = "Provide exactly one Lambda package source: filename or s3_bucket with s3_key."
    }
  }
}


resource "aws_lambda_alias" "this" {
  for_each         = var.aliases
  name             = each.key
  description      = try(each.value.description, null)
  function_name    = aws_lambda_function.this.function_name
  function_version = each.value.function_version
}


resource "aws_lambda_event_source_mapping" "this" {
  for_each          = var.event_source_mappings
  event_source_arn  = each.value.event_source_arn
  function_name     = aws_lambda_function.this.arn
  batch_size        = each.value.batch_size
  enabled           = each.value.enabled
  starting_position = try(each.value.starting_position, null)
}
