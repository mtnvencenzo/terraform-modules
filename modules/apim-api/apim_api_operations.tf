resource "azurerm_api_management_api_operation" "apim_api_version_operation" {
  for_each = toset(var.operations)

  api_name              = azurerm_api_management_api.apim_api_version.name
  api_management_name   = var.apim_instance.name
  resource_group_name   = var.apim_instance.resource_group_name

  operation_id          = "${replace(" ", lower("${each.method}-${each.name}"), "-")}"
  method                = "${upper(each.methos)}"
  display_name          = each.value.name
  url_template          = each.value.url_template
  description           = each.value.description

  response {
    status_code = each.value.success_status_code
  }
}

resource "azurerm_api_management_api_operation_policy" "apim_api_version_operation_policy" {
  count                 = length(var.operations)

  api_name              = azurerm_api_management_api.apim_api_version.name
  api_management_name   = var.apim_instance.name
  resource_group_name   = var.apim_instance.resource_group_name
  operation_id          = "${replace(" ", lower("${var.operations[count.index].method}-${var.operations[count.index].name}"), "-")}"

  xml_content           = var.operations[count.index].security_type == "anonymous" ? locals.anonomous_operation_policy : locals.b2c_auth_operation_policy
}
