output "id" {
  value = azurerm_cosmosdb_account.this.id
}


output "endpoint" {
  value = azurerm_cosmosdb_account.this.endpoint
}


output "database_names" {
  value = keys(azurerm_cosmosdb_sql_database.this)
}
