resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  name                          = "sb-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = "Standard"
  minimum_tls_version           = "1.2"
  public_network_access_enabled = var.public_network_access_enabled
  local_auth_enabled            = var.local_auth_enabled

  identity {
    type = "SystemAssigned"
  }

  # network_rule_set {
  #     default_action                  = "Deny"
  #     public_network_access_enabled   = false
  #     trusted_services_allowed        = true

  #     dynamic "network_rules" {
  #         for_each = var.subnet_ids
  #         content {
  #             subnet_id = network_rules.value
  #         }
  #     }
  # }

  lifecycle {
    prevent_destroy = true
  }

  tags = merge({
    Environment = var.environment
    Application = var.domain
  }, var.tags)
}