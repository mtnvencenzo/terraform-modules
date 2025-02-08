resource "azurerm_api_management_api_operation" "apim_api_version_operations" {
  for_each = tomap({
    for operation in var.operations :
      "${operation.method}_${operation.url_template}" => operation
  })

  api_name              = azurerm_api_management_api.apim_api_version.name
  api_management_name   = var.apim_instance.name
  resource_group_name   = var.apim_instance.resource_group_name

  operation_id          = replace(lower("${each.value.method}-${each.value.display_name}"), " ", "-")
  method                = "${upper(each.value.method)}"
  display_name          = each.value.display_name
  url_template          = each.value.url_template
  description           = each.value.description

  response {
    status_code = each.value.success_status_code
  }
}

resource "azurerm_api_management_api_operation_policy" "apim_api_version_operations_policy" {
  count                 = length(var.operations)

  api_name              = azurerm_api_management_api.apim_api_version.name
  api_management_name   = var.apim_instance.name
  resource_group_name   = var.apim_instance.resource_group_name
  operation_id          = replace(lower("${var.operations[count.index].method}-${var.operations[count.index].display_name}"), " ", "-")

  xml_content           = var.operations[count.index].security_type == "anonymous" ? local.anonomous_operation_policy : local.b2c_auth_operation_policy

  depends_on = [ 
    azurerm_api_management_api_operation.apim_api_version_operations
  ]
}
