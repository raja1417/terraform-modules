output "id" {
  value = azurerm_kubernetes_cluster.this.id
}


output "kube_config" {
  value     = azurerm_kubernetes_cluster.this.kube_config
  sensitive = true
}


output "node_pool_ids" {
  value = {
    for k, v in azurerm_kubernetes_cluster_node_pool.this :
    k => v.id
  }
}
