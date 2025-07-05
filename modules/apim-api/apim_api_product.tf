resource "azurerm_api_management_product" "apim_api_product" {
  count                 = length(var.subscriptions) > 0 ? 1 : 0
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
  count               = length(var.subscriptions) > 0 ? 1 : 0
  api_name            = azurerm_api_management_api.apim_api_version.name
  product_id          = azurerm_api_management_product.apim_api_product.product_id
  resource_group_name = var.apim_instance.resource_group_name
  api_management_name = var.apim_instance.name
}

resource "azurerm_api_management_subscription" "apim_api_product_subscriptions" {
  for_each = tomap({
    for subscription in var.subscriptions :
    subscription.name => subscription
  })

  resource_group_name = var.apim_instance.resource_group_name
  api_management_name = var.apim_instance.name
  product_id          = azurerm_api_management_product.apim_api_product.id
  display_name        = each.value.name
  state               = "active"
  subscription_id     = replace(replace(lower(each.value.name), " ", "-"), ".", "-")
  primary_key         = each.value.primary_key
  secondary_key       = each.value.secondary_key
  allow_tracing       = false

  depends_on = [
    azurerm_api_management_product.apim_api_product
  ]
}


