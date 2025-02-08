resource "azurerm_key_vault" "keyvault" {
  name = "kv-${var.sub}-${var.region}-${var.environment}-${var.shortdomain}-${var.sequence}"
  
  resource_group_name             = var.resource_group_name
  location                        = var.resource_group_location
  tenant_id                       = var.tenant_id
  enabled_for_disk_encryption     = true
  purge_protection_enabled        = true
  soft_delete_retention_days      = 7
  enabled_for_template_deployment = true
  enabled_for_deployment          = true
  sku_name                        = "standard"

  tags = {
      Environment = var.environment
      Application = var.domain
  }

  network_acls {
    bypass                      = "AzureServices"
    default_action              = "Allow"
    virtual_network_subnet_ids  = var.virtual_network_subnet_ids
  }

  lifecycle {
    prevent_destroy = true
  }
}


resource "azurerm_key_vault_access_policy" "keyvault_pipeline_access_policy" {
    key_vault_id        = azurerm_key_vault.keyvault.id
    tenant_id           = var.tenant_id
    object_id           = var.pipeline_object_id
    key_permissions     = [ "Get", "List", "Update", "Create", "Delete", "Recover", "Backup", "Restore" ]
    secret_permissions  = [ "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore" ]

    depends_on = [
      azurerm_key_vault.keyvault
    ]
}

resource "azurerm_key_vault_secret" "keyvault_secrets" {
  for_each = tomap({
    for secret in var.secrets :
      secret.name => secret
  })

  name = each.value.name
  value = each.value.value
  key_vault_id = azurerm_key_vault.keyvault.id

  lifecycle {
    ignore_changes = each.value.ignore_value == true ? [ value ] : []
  }

  depends_on = [ 
    azurerm_key_vault.keyvault,
    azurerm_key_vault_access_policy.keyvault_pipeline_access_policy
  ]
}

