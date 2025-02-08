resource "azurerm_api_management_api_operation" "apim_api_version_operations" {
  for_each = tomap({
    for operation in var.operations :
      "v${var.api.version}_${operation.method}_${operation.url_template}" => operation
  })

  api_name              = azurerm_api_management_api.apim_api_version.name
  api_management_name   = var.apim_instance.name
  resource_group_name   = var.apim_instance.resource_group_name

  operation_id          = replace(lower("v${var.api.version}-${each.value.method}-${each.value.display_name}"), " ", "-")
  method                = "${upper(each.value.method)}"
  display_name          = each.value.display_name
  url_template          = each.value.url_template
  description           = each.value.description

  dynamic "template_parameter" {
      for_each = toset(each.value.template_parameters)

      content {
        name      = template_parameter.value["name"]
        type      = template_parameter.value["type"]
        required  = true
      }
  }

  response {
    status_code = each.value.success_status_code
  }
}

resource "azurerm_api_management_api_operation_policy" "apim_api_version_operations_policy" {
  for_each = tomap({
    for operation in var.operations :
      "v${var.api.version}_${operation.method}_${operation.url_template}" => operation
  })

  api_name              = azurerm_api_management_api.apim_api_version.name
  api_management_name   = var.apim_instance.name
  resource_group_name   = var.apim_instance.resource_group_name
  operation_id          = replace(lower("v${var.api.version}-${each.value.method}-${each.value.display_name}"), " ", "-")

  xml_content           = each.value.security_type == "anonymous" ? local.anonomous_operation_policy : local.b2c_auth_operation_policy

  depends_on = [ 
    azurerm_api_management_api_operation.apim_api_version_operations,
    azurerm_api_management_policy_fragment.apim_api_cors_policy_fragment,
    azurerm_api_management_policy_fragment.apim_api_b2c_policy_fragment
  ]
}
