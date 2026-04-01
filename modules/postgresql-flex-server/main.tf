resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  name                          = "psqlfs-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  delegated_subnet_id           = var.delegated_subnet_id
  private_dns_zone_id           = var.private_dns_zone_id
  storage_mb                    = var.storage_mb
  storage_tier                  = var.storage_tier
  sku_name                      = var.sku
  administrator_login           = var.administrator_login
  administrator_password        = var.administrator_password
  version                       = var.version
  create_mode                   = var.create_mode
  auto_grow_enabled             = var.auto_grow_enabled
  public_network_access_enabled = var.public_network_access_enabled

  tags = merge({
    Environment = var.environment
    Application = var.domain
  }, var.tags)

  authentication {
    password_auth_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      zone,
      high_availability[0].standby_availability_zone
    ]
  }
}