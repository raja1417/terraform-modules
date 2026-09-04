output "cluster_name" {
  value = aws_eks_cluster.this.name
}


output "cluster_arn" {
  value = aws_eks_cluster.this.arn
}


output "endpoint" {
  value = aws_eks_cluster.this.endpoint
}


output "node_group_arns" {
  value = {
    for k, v in aws_eks_node_group.this :
    k => v.arn
  }
}
