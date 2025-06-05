resource "azurerm_search_service" "search" {
  name                          = "srch-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  replica_count                 = var.replica_count
  partition_count               = var.partition_count
  public_network_access_enabled = var.public_network_access_enabled

  identity {
    type = "SystemAssigned"
  }

  tags = merge({
    Environment = var.environment
    Application = var.domain
  }, var.tags)
} 