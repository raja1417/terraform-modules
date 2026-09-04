output "id" {
  value = azurerm_synapse_workspace.this.id
}


output "connectivity_endpoints" {
  value = azurerm_synapse_workspace.this.connectivity_endpoints
}


output "principal_id" {
  value = azurerm_synapse_workspace.this.identity[0].principal_id
}
