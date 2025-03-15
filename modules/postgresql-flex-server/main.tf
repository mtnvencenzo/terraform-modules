resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
    name                      = "psqlfs-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
    location                  = var.location
    resource_group_name       = var.resource_group_name
    delegated_subnet_id       = var.delegated_subnet_id
    private_dns_zone_id       = var.private_dns_zone_id
    storage_mb                = var.storage
    sku_name                  = var.sku
    administrator_login       = var.administrator_login
    administrator_password    = var.administrator_password
    version                   = var.postgres_version
    create_mode               = var.create_mode

    lifecycle {
      prevent_destroy         = true
      ignore_changes          = [ "zone" ]
    }

    tags = merge({
        Environment = var.environment
        Application = var.domain
    }, var.tags)
}