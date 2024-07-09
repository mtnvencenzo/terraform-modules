resource "azurerm_servicebus_queue" "servicebus_queue" {
  namespace_id                                = var.namespace_id
  name                                        = "sbq-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.name_discriminator}-${var.sequence}"
  lock_duration                               = var.lock_duration
  requires_duplicate_detection                = var.requires_duplicate_detection
  duplicate_detection_history_time_window     = var.duplicate_detection_history_time_window
  requires_session                            = var.requires_session

  dead_lettering_on_message_expiration        = var.dead_lettering_on_message_expiration
  max_delivery_count                          = var.max_delivery_count
}