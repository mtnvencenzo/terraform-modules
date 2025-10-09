resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                     = "evhns-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = "Standard"
  auto_inflate_enabled     = true
  maximum_throughput_units = 4
  capacity                 = 1

  network_rulesets {
    default_action                 = "Deny"
    trusted_service_access_enabled = true
    virtual_network_rule = [
      for rule in var.subnet_ids : {
        subnet_id                                       = rule
        ignore_missing_virtual_network_service_endpoint = false
      }
    ]
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = merge({
    Environment = var.environment
    Application = var.domain
  }, var.tags)
}