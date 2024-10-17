resource "azurerm_cosmosdb_account" "cosmosdb_account" {
    name = "cosmos-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
    location = var.location
    resource_group_name = var.resource_group_name
    offer_type = "Standard"
    kind = "GlobalDocumentDB"

    automatic_failover_enabled = true
    is_virtual_network_filter_enabled = true
    dynamic "virtual_network_rule" {
      for_each = var.subnet_ids
      content {
        id = virtual_network_rule.value
      }
    }

    consistency_policy {
      consistency_level = var.consistency_level
      max_interval_in_seconds = var.max_interval_in_seconds
      max_staleness_prefix = var.max_staleness_prefix
    }

    geo_location {
      location = var.geo_location
      failover_priority = 0
    }

    lifecycle {
      prevent_destroy = true
    }

    tags = {
        Environment = var.environment
        Application = var.domain
    }
}

resource "azurerm_monitor_metric_alert" "cosmosdb_ru_usage_warning_alert" {
    count = var.enable_monitor_alerts == true ? 1 : 0
    name = "mma--${var.sub}-${var.region}-${var.environment}-${var.domain}-warning-alert"
    resource_group_name = var.resource_group_name
    scopes = [azurerm_cosmosdb_account.cosmosdb_account.id]
    frequency = "PT5M"
    window_size = "PT5M"

    criteria {
      metric_name = "NormalizedRUConsumption"
      operator = "GreaterThan"
      threshold = 80
      aggregation = "Average"
      metric_namespace = "Microsoft.DocumentDB/databaseAccounts"
    }

    action {
      action_group_id = var.action_group_id
    }

    description = "Alert when RU usage reaches 80%"
    severity = 3
}

resource "azurerm_monitor_metric_alert" "cosmosdb_ru_usage_critical_alert" {
    count = var.enable_monitor_alerts == true ? 1 : 0
    name = "mma--${var.sub}-${var.region}-${var.environment}-${var.domain}-critical-alert"
    resource_group_name = var.resource_group_name
    scopes = [azurerm_cosmosdb_account.cosmosdb_account.id]
    frequency = "PT5M"
    window_size = "PT5M"

    criteria {
      metric_name = "NormalizedRUConsumption"
      operator = "GreaterThan"
      threshold = 90
      aggregation = "Average"
      metric_namespace = "Microsoft.DocumentDB/databaseAccounts"
    }

    action {
      action_group_id = var.action_group_id
    }

    description = "Alert when RU usage reaches 90%"
    severity = 1
}