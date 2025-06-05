resource "azurerm_api_management_product" "apim_api_product" {
  product_id            = "${var.environment}-${var.domain}-${var.name_discriminator}"
  resource_group_name   = var.apim_instance.resource_group_name
  api_management_name   = var.apim_instance.name
  display_name          = "${title(var.environment)} ${title(var.domain)} ${title(var.name_discriminator)}"
  subscription_required = true
  subscriptions_limit   = length(var.subscriptions)
  approval_required     = length(var.subscriptions) > 0 ? true : false
  published             = true
}

resource "azurerm_api_management_product_api" "apim_api_product_api" {
  api_name            = azurerm_api_management_api.apim_api_version.name
  product_id          = azurerm_api_management_product.apim_api_product.product_id
  resource_group_name = var.apim_instance.resource_group_name
  api_management_name = var.apim_instance.name
}
