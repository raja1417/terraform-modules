output "security_group_id" {
  description = "Security group ID for compute resources"
  value       = aws_security_group.compute.id
}

output "security_group_name" {
  description = "Security group name"
  value       = aws_security_group.compute.name
}
