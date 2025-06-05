resource "azurerm_user_assigned_identity" "aca_user_identity" {
  name                = "mi-${var.sub}-${var.region}-${var.environment}-${var.domain}${var.name_discriminator}-${var.sequence}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  tags = merge({
    Environment = var.environment
    Application = var.domain
  }, var.tags)
}

resource "azurerm_role_assignment" "aca_user_identity_acr_role_assignment" {
  scope                = var.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.aca_user_identity.principal_id

  depends_on = [
    azurerm_user_assigned_identity.aca_user_identity
  ]
}