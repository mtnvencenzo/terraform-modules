resource "azurerm_servicebus_topic" "servicebus_topic" {
    namespace_id                                = var.namespace_id
    name                                        = "sbt-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.name_discriminator}-${var.sequence}"

    requires_duplicate_detection                = var.requires_duplicate_detection
    duplicate_detection_history_time_window     = var.duplicate_detection_history_time_window
    support_ordering                            = var.support_ordering 
}