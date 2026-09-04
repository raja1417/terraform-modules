resource "aws_redshift_subnet_group" "this" {
  count      = length(var.subnet_ids) > 0 ? 1 : 0
  name       = "${var.name}-subnets"
  subnet_ids = var.subnet_ids
  tags       = local.common_tags
}


resource "aws_redshift_parameter_group" "this" {
  count  = length(var.parameters) > 0 ? 1 : 0
  name   = "${var.name}-params"
  family = var.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameters

    content {
      name  = parameter.key
      value = parameter.value
    }
  }

  tags = local.common_tags
}


resource "aws_redshift_cluster" "this" {
  cluster_identifier                  = var.name
  database_name                       = var.database_name
  master_username                     = var.master_username
  master_password                     = var.master_password
  node_type                           = var.node_type
  cluster_type                        = var.cluster_type
  number_of_nodes                     = var.cluster_type == "single-node" ? null : var.number_of_nodes
  cluster_subnet_group_name           = try(aws_redshift_subnet_group.this[0].name, null)
  vpc_security_group_ids              = var.vpc_security_group_ids
  encrypted                           = var.encrypted
  kms_key_id                          = var.kms_key_id
  publicly_accessible                 = var.publicly_accessible
  skip_final_snapshot                 = var.skip_final_snapshot
  final_snapshot_identifier           = var.skip_final_snapshot ? null : "${var.name}-final"
  automated_snapshot_retention_period = var.automated_snapshot_retention_period
  cluster_parameter_group_name        = try(aws_redshift_parameter_group.this[0].name, null)
  tags                                = local.common_tags

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      master_password,
    ]
  }
}
