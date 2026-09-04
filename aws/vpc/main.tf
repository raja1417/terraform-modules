locals {
  public_subnets = {
    for k, v in var.subnets :
    k => v
    if try(v.public, false)
  }
  private_subnets = {
    for k, v in var.subnets :
    k => v
    if !try(v.public, false)
  }
  nat_subnets = var.single_nat_gateway ? slice(keys(local.public_subnets), 0, min(length(local.public_subnets), 1)) : keys(local.public_subnets)
}


resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge(local.common_tags, {
    Name = var.name
  })

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_internet_gateway" "this" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id
  tags = merge(local.common_tags, {
    Name = "${var.name}-igw"
  })
}


resource "aws_subnet" "this" {
  for_each                = var.subnets
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  availability_zone       = try(each.value.availability_zone, null)
  map_public_ip_on_launch = try(each.value.map_public_ip_on_launch, try(each.value.public, false))
  tags = merge(local.common_tags, try(each.value.tags, {}), {
    Name = "${var.name}-${each.key}"
  })

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_eip" "nat" {
  for_each = var.create_nat_gateway ? toset(local.nat_subnets) : toset([])
  domain   = "vpc"
  tags = merge(local.common_tags, {
    Name = "${var.name}-${each.key}-nat-eip"
  })
}


resource "aws_nat_gateway" "this" {
  for_each      = aws_eip.nat
  allocation_id = each.value.id
  subnet_id     = aws_subnet.this[each.key].id
  tags = merge(local.common_tags, {
    Name = "${var.name}-${each.key}-nat"
  })
  depends_on = [
    aws_internet_gateway.this,
  ]
}


resource "aws_route_table" "public" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this[0].id
  }

  tags = merge(local.common_tags, {
    Name = "${var.name}-public"
  })
}


resource "aws_route_table_association" "public" {
  for_each       = local.public_subnets
  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.public[0].id
}


resource "aws_route_table" "private" {
  for_each = local.private_subnets
  vpc_id   = aws_vpc.this.id

  dynamic "route" {
    for_each = length(aws_nat_gateway.this) == 0 ? [] : [1]

    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.this[var.single_nat_gateway ? local.nat_subnets[0] : lookup(var.private_subnet_nat_gateway_keys, each.key, local.nat_subnets[0])].id
    }
  }

  tags = merge(local.common_tags, {
    Name = "${var.name}-${each.key}-private"
  })
}


resource "aws_route_table_association" "private" {
  for_each       = local.private_subnets
  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}
