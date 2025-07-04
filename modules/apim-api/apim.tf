resource "azurerm_key_vault_access_policy" "apim_keyvault_policy" {
  count              = var.key_vault.id != "" ? 1 : 0
  key_vault_id       = var.key_vault.id
  tenant_id          = var.tenant_id
  object_id          = var.apim_instance.principal_id
  key_permissions    = ["Get", "List"]
  secret_permissions = ["Get", "List"]
}

resource "azurerm_api_management_logger" "apim_appinsights_logger" {
  name                = "${var.environment}-${var.domain}-appinsights-logger"
  description         = "${title(var.environment)} ${var.domain} app insights logger for the api management instance"
  resource_group_name = var.apim_instance.resource_group_name
  api_management_name = var.apim_instance.name
  resource_id         = var.application_insights.id

  application_insights {
    instrumentation_key = var.application_insights.instrumentation_key
  }
}