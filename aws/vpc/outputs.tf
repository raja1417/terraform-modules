output "vpc_id" {
  value = aws_vpc.this.id
}


output "vpc_cidr_block" {
  value = aws_vpc.this.cidr_block
}


output "subnet_ids" {
  value = {
    for k, v in aws_subnet.this :
    k => v.id
  }
}


output "public_subnet_ids" {
  value = [
    for k in keys(local.public_subnets) :
    aws_subnet.this[k].id
  ]
}


output "private_subnet_ids" {
  value = [
    for k in keys(local.private_subnets) :
    aws_subnet.this[k].id
  ]
}
