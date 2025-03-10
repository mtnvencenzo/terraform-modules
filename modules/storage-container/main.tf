resource "azurerm_storage_container" "storage_container" {
  for_each = tomap({
    for container in var.blob_containers :
      container.name => container
  })

  name = each.value.name
  storage_account_name    = var.storage_account_name
  container_access_type   = each.value.container_access_type
}