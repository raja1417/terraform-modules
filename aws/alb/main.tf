resource "aws_lb" "this" {
  name                       = var.name
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = var.security_group_ids
  subnets                    = var.subnet_ids
  enable_deletion_protection = var.enable_deletion_protection

  dynamic "access_logs" {
    for_each = var.access_logs == null ? [] : [var.access_logs]

    content {
      bucket  = access_logs.value.bucket
      prefix  = try(access_logs.value.prefix, null)
      enabled = access_logs.value.enabled
    }
  }

  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_lb_target_group" "this" {
  for_each    = var.target_groups
  name        = "${var.name}-${each.key}"
  port        = each.value.port
  protocol    = each.value.protocol
  vpc_id      = each.value.vpc_id
  target_type = each.value.target_type

  dynamic "health_check" {
    for_each = try(each.value.health_check, null) == null ? [] : [each.value.health_check]

    content {
      path                = health_check.value.path
      matcher             = health_check.value.matcher
      interval            = health_check.value.interval
      timeout             = health_check.value.timeout
      healthy_threshold   = health_check.value.healthy_threshold
      unhealthy_threshold = health_check.value.unhealthy_threshold
    }
  }

  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_lb_listener" "this" {
  for_each          = var.listeners
  load_balancer_arn = aws_lb.this.arn
  port              = each.value.port
  protocol          = each.value.protocol
  certificate_arn   = try(each.value.certificate_arn, null)
  ssl_policy        = try(each.value.certificate_arn, null) == null ? null : each.value.ssl_policy

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.value.target_group_key].arn
  }
}
