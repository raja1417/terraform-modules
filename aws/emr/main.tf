resource "aws_emr_cluster" "this" {
  name                              = var.name
  release_label                     = var.release_label
  applications                      = var.applications
  service_role                      = var.service_role
  log_uri                           = var.log_uri
  keep_job_flow_alive_when_no_steps = var.keep_job_flow_alive_when_no_steps
  termination_protection            = var.termination_protection

  ec2_attributes {
    subnet_id        = var.subnet_id
    instance_profile = var.job_flow_role
  }


  master_instance_group {
    instance_type = var.master_instance_type
  }


  core_instance_group {
    instance_type  = var.core_instance_type
    instance_count = var.core_instance_count
  }


  dynamic "bootstrap_action" {
    for_each = var.bootstrap_actions

    content {
      name = bootstrap_action.value.name
      path = bootstrap_action.value.path
      args = bootstrap_action.value.args
    }
  }


  dynamic "step" {
    for_each = var.steps

    content {
      name              = step.value.name
      action_on_failure = step.value.action_on_failure

      hadoop_jar_step {
        jar        = step.value.hadoop_jar_step.jar
        main_class = try(step.value.hadoop_jar_step.main_class, null)
        args       = step.value.hadoop_jar_step.args
      }
    }
  }


  tags = local.common_tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_emr_managed_scaling_policy" "this" {
  count      = var.managed_scaling_policy == null ? 0 : 1
  cluster_id = aws_emr_cluster.this.id

  compute_limits {
    unit_type                       = var.managed_scaling_policy.unit_type
    minimum_capacity_units          = var.managed_scaling_policy.minimum_capacity_units
    maximum_capacity_units          = var.managed_scaling_policy.maximum_capacity_units
    maximum_ondemand_capacity_units = try(var.managed_scaling_policy.maximum_ondemand_capacity_units, null)
    maximum_core_capacity_units     = try(var.managed_scaling_policy.maximum_core_capacity_units, null)
  }
}
