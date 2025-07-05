
output "path" {
  value = azurerm_api_management_api.apim_api_version.path
}

output "version" {
  value = azurerm_api_management_api.apim_api_version.version
}

output "backend_id" {
  value = azurerm_api_management_backend.apim_api_backend.id
}

output "backend_name" {
  value = azurerm_api_management_backend.apim_api_backend.name
}