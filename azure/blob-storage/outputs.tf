output "id" {
  value = azurerm_storage_account.this.id
}


output "name" {
  value = azurerm_storage_account.this.name
}


output "container_names" {
  value = keys(azurerm_storage_container.this)
}
