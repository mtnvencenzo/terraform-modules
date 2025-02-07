output "id" {
    value = azurerm_key_vault.keyvault.id
}

output "name" {
    value = azurerm_key_vault.keyvault.name
}

output "virtual_network_subnet_ids" {
    value = azurerm_key_vault.keyvault.network_acls.virtual_network_subnet_ids
}

