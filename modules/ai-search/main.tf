resource "azurerm_search_service" "search" {
  name                = "srch-${var.environment}-${var.domain}-${var.sequence}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  replica_count       = var.replica_count
  partition_count     = var.partition_count
  public_network_access_enabled = var.public_network_access_enabled

  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      Domain      = var.domain
      Sequence    = var.sequence
      Sub         = var.sub
      Region      = var.region
    }
  )
} 