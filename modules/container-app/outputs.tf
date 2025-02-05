
output "id" {
    value = azurerm_container_app.aca.id
}

output "name" {
    value = azurerm_container_app.aca.name
}

output "ingress_fqdn" {
    value = azurerm_container_app.aca.ingress[0].fqdn
}