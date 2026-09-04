resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  iam_instance_profile        = var.iam_instance_profile
  key_name                    = var.key_name
  user_data                   = var.user_data
  associate_public_ip_address = var.associate_public_ip_address
  monitoring                  = var.monitoring
  disable_api_termination     = var.disable_api_termination

  metadata_options {
    http_endpoint               = var.metadata_options.http_endpoint
    http_tokens                 = var.metadata_options.http_tokens
    http_put_response_hop_limit = var.metadata_options.http_put_response_hop_limit
    instance_metadata_tags      = var.metadata_options.instance_metadata_tags
  }


  root_block_device {
    volume_type           = var.root_block_device.volume_type
    volume_size           = var.root_block_device.volume_size
    encrypted             = var.root_block_device.encrypted
    kms_key_id            = try(var.root_block_device.kms_key_id, null)
    delete_on_termination = var.root_block_device.delete_on_termination
    iops                  = try(var.root_block_device.iops, null)
    throughput            = try(var.root_block_device.throughput, null)
  }


  dynamic "ebs_block_device" {
    for_each = var.ebs_block_devices

    content {
      device_name           = ebs_block_device.value.device_name
      volume_type           = ebs_block_device.value.volume_type
      volume_size           = ebs_block_device.value.volume_size
      encrypted             = ebs_block_device.value.encrypted
      kms_key_id            = try(ebs_block_device.value.kms_key_id, null)
      delete_on_termination = ebs_block_device.value.delete_on_termination
      iops                  = try(ebs_block_device.value.iops, null)
      throughput            = try(ebs_block_device.value.throughput, null)
    }
  }

  tags = merge(local.common_tags, {
    Name = var.name
  })

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_eip" "this" {
  count    = var.create_eip ? 1 : 0
  instance = aws_instance.this.id
  domain   = "vpc"
  tags = merge(local.common_tags, {
    Name = "${var.name}-eip"
  })
}
