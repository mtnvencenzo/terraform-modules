resource "azurerm_storage_container" "storage_container" {
  name                  = var.container_name
  storage_account_name  = var.storage_account_name
  container_access_type = var.container_access_type
}

resource "azurerm_role_assignment" "storage_container_role_assignments" {
  for_each = tomap({
    for role in var.role_assignments :
    "${role.role_definition_name}-${role.principal_id}" => role
  })

  scope                = azurerm_storage_container.storage_container.resource_manager_id
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
}