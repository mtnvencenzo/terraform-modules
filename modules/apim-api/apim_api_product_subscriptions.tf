resource "azurerm_api_management_subscription" "apim_api_product_subscriptions" {
  for_each = tomap({
    for subscription in var.subscriptions :
      subscription.name => subscription
  })

  resource_group_name   = var.apim_instance.resource_group_name
  api_management_name   = var.apim_instance.name
  product_id            = azurerm_api_management_product.apim_api_product.id
  display_name          = each.value.name
  state                 = "active"
  subscription_id       = replace(replace("${lower(each.value.name)}", " ", "_"), "-", "_")
  primary_key           = each.value.primary_key
  secondary_key         = each.value.secondary_key
  allow_tracing         = false

  depends_on = [ 
    azurerm_api_management_product.apim_api_product
  ]
}


