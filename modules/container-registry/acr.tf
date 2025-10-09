resource "azurerm_container_registry" "acr" {
  name                  = "acr${var.sub}${var.region}${var.environment}${var.domain}${var.sequence}"
  resource_group_name   = var.resource_group_name
  location              = var.resource_group_location
  sku                   = var.sku
  admin_enabled         = var.admin_enabled
  data_endpoint_enabled = var.data_endpoint_enabled

  identity {
    type = "SystemAssigned"
  }

  tags = merge({
    Environment = var.environment
    Application = var.domain
  }, var.tags)

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      tags
    ]
  }
}