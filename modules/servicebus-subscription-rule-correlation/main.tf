resource "azurerm_servicebus_subscription_rule" "servucebus_subscription_rule" {
  subscription_id = var.subscription_id
  name            = "label-${var.correlation_filter_label}"
  filter_type     = "CorrelationFilter"

  correlation_filter {
    label = var.correlation_filter_label
  }
}

