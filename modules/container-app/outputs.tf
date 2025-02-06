
output "id" {
    value = azurerm_container_app.aca.id
}

output "name" {
    value = azurerm_container_app.aca.name
}

output "ingress_fqdn" {
    value = azurerm_container_app.aca.ingress[0].fqdn
}

output "managed_identity_name" {
    value = azurerm_user_assigned_identity.aca_user_identity.name
}

output "managed_identity_id" {
    value = azurerm_user_assigned_identity.aca_user_identity.id
}

output "managed_identity_principal_id" {
    value = azurerm_user_assigned_identity.aca_user_identity.principal_id
}

