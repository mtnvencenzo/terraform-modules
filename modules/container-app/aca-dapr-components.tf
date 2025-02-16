resource "azurerm_container_app_environment_dapr_component" "aca_dapr_components" {
  for_each = tomap({
    for dapr_component in local.dapr_components :
      dapr_component.name => dapr_component
  })

  container_app_environment_id  = var.container_app_environment_id
  init_timeout                  = "20s"
  ignore_errors                 = false
  name                          = each.value.name
  component_type                = each.value.component_type
  version                       = each.value.version != null ? each.value.version : "v1"
  scopes                        = each.value.scopes != null ? each.value.scopes : [var.dapr.app_id]

  dynamic "metadata" {
    for_each = each.value.metadata
    
    content {
      name = metadata.value["name"]
      value = metadata.value["name"] == "azureClientId" ? azurerm_user_assigned_identity.aca_user_identity.client_id : metadata.value["value"]
    }
  }

  depends_on = [ azurerm_container_app.aca, azurerm_user_assigned_identity.aca_user_identity ]
}
