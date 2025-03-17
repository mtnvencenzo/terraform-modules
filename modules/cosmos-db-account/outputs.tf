output "cosmosdb_account_name" {
    value = azurerm_cosmosdb_account.cosmosdb_account.name
}

output "cosmosdb_account_endpoint" {
    value = azurerm_cosmosdb_account.cosmosdb_account.endpoint
}

output "cosmosdb_account_key" {
    value = azurerm_cosmosdb_account.cosmosdb_account.primary_key
}

output "cosmosdb_reader_role_id" {
    value = azurerm_cosmosdb_sql_role_definition.cosmosdb_custom_reader_role_definition.id
}

output "cosmosdb_contributor_role_id" {
    value = azurerm_cosmosdb_sql_role_definition.cosmosdb_custom_contributor_role_definition.id
}

output "cosmosdb_enpdpoint" {
    value = azurerm_cosmosdb_account.cosmosdb_account.endpoint
}
