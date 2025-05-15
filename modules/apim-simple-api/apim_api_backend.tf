resource "azurerm_api_management_backend" "apim_api_backend" {
  name                = "${var.environment}-${var.domain}-${var.name_discriminator}-backend"
  resource_group_name = var.apim_instance.resource_group_name
  api_management_name = var.apim_instance.name
  protocol            = "http"
  url                 = "https://${var.api.ingress_fqdn}/${var.name_discriminator}/v${var.api.version}"
}

