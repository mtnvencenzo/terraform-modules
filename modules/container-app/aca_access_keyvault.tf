resource "azurerm_key_vault_access_policy" "aca_keyvault_policy" {
    count                               = var.key_vault != null ? 1 : 0
    key_vault_id                        = var.key_vault.id
    tenant_id                           = var.tenant_id
    object_id                           = azurerm_user_assigned_identity.aca.principal_id
    key_permissions                     = ["Get", "List"]
    secret_permissions                  = ["Get", "List"]

    depends_on = [
        azurerm_user_assigned_identity.aca_user_identity
    ]
}