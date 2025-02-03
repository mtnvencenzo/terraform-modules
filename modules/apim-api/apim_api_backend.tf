
resource "azurerm_api_management_named_value" "apim_api_backend_named_value_apimhostkey" {
  name                = "${var.environment}-${var.domain}-${var.name_discriminator}-apimhostkey"
  resource_group_name = var.apim_instance.resource_group_name
  api_management_name = var.apim_instance.name
  display_name        = "${var.environment}-${var.domain}-${var.name_discriminator}-apimhostkey"
  secret              = true

  value_from_key_vault {
    secret_id = var.keyvault_apimhostkey_secret_id
  }
}

resource "azurerm_api_management_backend" "apim_api_backend" {
  name                = "${var.environment}-${var.domain}-${var.name_discriminator}-backend"
  resource_group_name = var.apim_instance.resource_group_name
  api_management_name = var.apim_instance.name
  protocol            = "http"
  url                 = "https://${var.api.ingress_fqdn}/${var.name_discriminator}/v${var.api.version}"
  
  credentials {
    header = {
      "X-Apim-Host-Key" = "{{${azurerm_api_management_named_value.apim_api_backend_named_value_apimhostkey.name}}}"
    }
  }

  depends_on = [
    azurerm_api_management_named_value.apim_api_backend_named_value_apimhostkey
  ]
}

