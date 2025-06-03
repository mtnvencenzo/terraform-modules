output "search_service_name" {
  description = "Name of the created search service"
  value       = azurerm_search_service.search.name
}

output "search_service_id" {
  description = "Resource ID of the search service"
  value       = azurerm_search_service.search.id
}

output "search_service_primary_key" {
  description = "Primary key of the search service"
  value       = azurerm_search_service.search.primary_key
  sensitive   = true
}

output "search_service_secondary_key" {
  description = "Secondary key of the search service"
  value       = azurerm_search_service.search.secondary_key
  sensitive   = true
}

output "search_service_identity" {
  description = "Managed identity of the search service"
  value       = azurerm_search_service.search.identity
} 