resource "aws_eks_cluster" "this" {
  name                      = var.name
  role_arn                  = var.cluster_role_arn
  version                   = var.kubernetes_version
  enabled_cluster_log_types = var.enabled_cluster_log_types

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_group_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }


  dynamic "encryption_config" {
    for_each = var.kms_key_arn == null ? [] : [var.kms_key_arn]

    content {
      provider {
        key_arn = encryption_config.value
      }

      resources = [
        "secrets",
      ]
    }
  }

  tags = local.common_tags

  lifecycle {
    prevent_destroy = true
  }
}


resource "aws_eks_node_group" "this" {
  for_each        = var.node_groups
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = each.key
  node_role_arn   = var.node_role_arn
  subnet_ids      = coalesce(each.value.subnet_ids, var.subnet_ids)
  instance_types  = each.value.instance_types
  capacity_type   = each.value.capacity_type
  disk_size       = each.value.disk_size
  labels          = each.value.labels

  scaling_config {
    desired_size = each.value.desired_size
    min_size     = each.value.min_size
    max_size     = each.value.max_size
  }


  dynamic "taint" {
    for_each = each.value.taints

    content {
      key    = taint.value.key
      value  = try(taint.value.value, null)
      effect = taint.value.effect
    }
  }

  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      scaling_config[0].desired_size,
    ]
  }
}


resource "aws_eks_addon" "this" {
  for_each                    = var.addons
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = each.key
  addon_version               = try(each.value.version, null)
  resolve_conflicts_on_create = each.value.resolve_conflicts_on_create
  resolve_conflicts_on_update = each.value.resolve_conflicts_on_update
  configuration_values        = try(each.value.configuration_values, null)
}
