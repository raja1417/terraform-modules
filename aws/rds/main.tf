resource "aws_db_subnet_group" "this" {
  count      = length(var.subnet_ids) > 0 ? 1 : 0
  name       = "${var.name}-subnets"
  subnet_ids = var.subnet_ids
  tags       = local.common_tags
}


resource "aws_db_instance" "this" {
  identifier                          = var.name
  engine                              = var.engine
  engine_version                      = var.engine_version
  instance_class                      = var.instance_class
  allocated_storage                   = var.allocated_storage
  max_allocated_storage               = var.max_allocated_storage
  db_name                             = var.db_name
  username                            = var.username
  password                            = var.manage_master_user_password ? null : var.password
  manage_master_user_password         = var.manage_master_user_password
  db_subnet_group_name                = try(aws_db_subnet_group.this[0].name, null)
  vpc_security_group_ids              = var.vpc_security_group_ids
  backup_retention_period             = var.backup_retention_period
  backup_window                       = "03:00-04:00"
  maintenance_window                  = "sun:04:00-sun:05:00"
  copy_tags_to_snapshot               = true
  delete_automated_backups            = false
  multi_az                            = var.multi_az
  storage_encrypted                   = var.storage_encrypted
  kms_key_id                          = var.kms_key_id
  deletion_protection                 = var.deletion_protection
  skip_final_snapshot                 = var.skip_final_snapshot
  final_snapshot_identifier           = var.skip_final_snapshot ? null : "${var.name}-final"
  monitoring_interval                 = var.monitoring_interval
  monitoring_role_arn                 = var.monitoring_role_arn
  performance_insights_enabled        = var.performance_insights_enabled
  performance_insights_kms_key_id     = try(coalesce(var.performance_insights_kms_key_id, var.kms_key_id), null)
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  iam_database_authentication_enabled = true
  auto_minor_version_upgrade          = true
  tags                                = local.common_tags

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      password,
    ]
  }
}
