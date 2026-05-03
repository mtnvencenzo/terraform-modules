resource "azurerm_servicebus_subscription_rule" "servucebus_subscription_rule" {
  subscription_id = var.subscription_id
  name            = "sql-${var.name}"
  filter_type     = "SqlFilter"

  sql_filter = var.sql_expression

  action = var.action
}

