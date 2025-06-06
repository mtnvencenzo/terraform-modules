resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = "cosmos-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  automatic_failover_enabled        = true
  is_virtual_network_filter_enabled = true

  dynamic "virtual_network_rule" {
    for_each = var.subnet_ids
    content {
      id = virtual_network_rule.value
    }
  }

  ip_range_filter = toset(var.ip_range_filter)

  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = var.max_interval_in_seconds
    max_staleness_prefix    = var.max_staleness_prefix
  }

  geo_location {
    location          = var.geo_location
    failover_priority = 0
  }

  tags = merge({
    Environment = var.environment
    Application = var.domain
  }, var.tags)

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      ip_range_filter
    ]
  }
}

resource "azurerm_role_assignment" "cosmos_search_account_reader_role_assignment" {
  for_each = tomap({
    for role_assignment in var.cosmos_db_account_reader_role_assignments :
    role_assignment.principal_id => role_assignment
  })

  scope                = azurerm_cosmosdb_account.cosmosdb_account.id
  role_definition_name = "Cosmos DB Account Reader Role"
  principal_id         = each.key
}


resource "azurerm_cosmosdb_sql_role_definition" "cosmosdb_custom_reader_role_definition" {
  name                = "Cosmos DB Custom Data Reader"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_account.name
  type                = "CustomRole"
  assignable_scopes   = [azurerm_cosmosdb_account.cosmosdb_account.id]

  permissions {
    data_actions = [
      "Microsoft.DocumentDB/databaseAccounts/readMetadata",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read"
    ]
  }
}


resource "azurerm_cosmosdb_sql_role_assignment" "sql_custom_reader_role_assignments" {
  for_each = tomap({
    for role_assignment in var.custom_reader_role_assignments :
    role_assignment.name => role_assignment
  })

  name                = each.value.name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_account.name
  role_definition_id  = azurerm_cosmosdb_sql_role_definition.cosmosdb_custom_reader_role_definition.id
  principal_id        = each.value.principal_id
  scope               = azurerm_cosmosdb_account.cosmosdb_account.id

  depends_on = [
    azurerm_cosmosdb_account.cosmosdb_account,
    azurerm_cosmosdb_sql_role_definition.cosmosdb_custom_reader_role_definition
  ]
}


resource "azurerm_cosmosdb_sql_role_definition" "cosmosdb_custom_contributor_role_definition" {
  name                = "Cosmos DB Custom Data Contributor"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_account.name
  type                = "CustomRole"
  assignable_scopes   = [azurerm_cosmosdb_account.cosmosdb_account.id]

  permissions {
    data_actions = [
      "Microsoft.DocumentDB/databaseAccounts/readMetadata",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*"
    ]
  }
}

resource "azurerm_cosmosdb_sql_role_assignment" "sql_custom_contributor_role_assignments" {
  for_each = tomap({
    for role_assignment in var.custom_contributor_role_assignments :
    role_assignment.name => role_assignment
  })

  name                = each.value.name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_account.name
  role_definition_id  = azurerm_cosmosdb_sql_role_definition.cosmosdb_custom_contributor_role_definition.id
  principal_id        = each.value.principal_id
  scope               = azurerm_cosmosdb_account.cosmosdb_account.id

  depends_on = [
    azurerm_cosmosdb_account.cosmosdb_account,
    azurerm_cosmosdb_sql_role_definition.cosmosdb_custom_contributor_role_definition
  ]
}

resource "azurerm_monitor_metric_alert" "cosmosdb_ru_usage_warning_alert" {
  count               = var.enable_monitor_alerts == true ? 1 : 0
  name                = "mma--${var.sub}-${var.region}-${var.environment}-${var.domain}-warning-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_cosmosdb_account.cosmosdb_account.id]
  frequency           = "PT5M"
  window_size         = "PT5M"

  criteria {
    metric_name      = "NormalizedRUConsumption"
    operator         = "GreaterThan"
    threshold        = 80
    aggregation      = "Average"
    metric_namespace = "Microsoft.DocumentDB/databaseAccounts"
  }

  tags = merge({
    Environment = var.environment
    Application = var.domain
  }, var.tags)

  action {
    action_group_id = var.action_group_id
  }

  description = "Alert when RU usage reaches 80%"
  severity    = 3
}

resource "azurerm_monitor_metric_alert" "cosmosdb_ru_usage_critical_alert" {
  count               = var.enable_monitor_alerts == true ? 1 : 0
  name                = "mma--${var.sub}-${var.region}-${var.environment}-${var.domain}-critical-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_cosmosdb_account.cosmosdb_account.id]
  frequency           = "PT5M"
  window_size         = "PT5M"

  criteria {
    metric_name      = "NormalizedRUConsumption"
    operator         = "GreaterThan"
    threshold        = 90
    aggregation      = "Average"
    metric_namespace = "Microsoft.DocumentDB/databaseAccounts"
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = merge({
    Environment = var.environment
    Application = var.domain
  }, var.tags)

  description = "Alert when RU usage reaches 90%"
  severity    = 1
}