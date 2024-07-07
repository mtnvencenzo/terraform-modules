resource "azurerm_communication_service" "communication_service" {
    name = "comm-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
    resource_group_name = var.resource_group_name
    data_location       = var.data_location
    
    tags = {
        Environment = var.environment
        Application = var.domain
    }
}