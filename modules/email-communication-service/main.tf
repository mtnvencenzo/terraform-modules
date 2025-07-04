resource "azurerm_email_communication_service" "email_communication_service" {
  name                = "emailcomm-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
  resource_group_name = var.resource_group_name
  data_location       = var.data_location

  lifecycle {
    prevent_destroy = true
  }

  tags = merge({
    Environment = var.environment
    Application = var.domain
  }, var.tags)
}