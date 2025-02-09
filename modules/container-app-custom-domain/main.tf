resource "azurerm_container_app_custom_domain" "container_app_custom_domain" {
  name                = var.name
  container_app_id    = var.container_app_id

  lifecycle {

    // When using an Azure created Managed Certificate these values must be added to ignore_changes to prevent resource recreation.
    ignore_changes = [
      certificate_binding_type,
      container_app_environment_certificate_id
    ]
  }
}
