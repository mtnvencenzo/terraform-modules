output "database_id" {
  value = azurerm_cosmosdb_sql_database.sql_db.id
}

output "database_name" {
  value = azurerm_cosmosdb_sql_database.sql_db.name
}