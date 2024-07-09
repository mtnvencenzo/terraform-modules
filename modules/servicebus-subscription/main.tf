resource "azurerm_servicebus_subscription" "servicebus_subscription" {
  topic_id            = var.topic_id
  name                = "sbs-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.name_discriminator}-${var.sequence}"
  max_delivery_count  = var.max_delivery_count
  forward_to          = var.forward_to
}
