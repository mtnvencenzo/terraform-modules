resource "azurerm_api_management_logger" "apim_appinsights_logger" {
  name                = "${var.environment}-${var.domain}-${var.name_discriminator}-appinsights-logger"
  description         = "${title(var.environment)} ${var.domain} ${var.name_discriminator} app insights logger for the api management instance"
  resource_group_name = var.apim_instance.resource_group_name
  api_management_name = var.apim_instance.name
  resource_id         = var.application_insights.id

  application_insights {
    instrumentation_key = var.application_insights.instrumentation_key
  }
}