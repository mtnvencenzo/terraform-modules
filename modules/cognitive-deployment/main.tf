# Azure OpenAI
resource "azurerm_cognitive_account" "cognitive_account" {
  name                = "coga-${var.sub}-${var.region}-${var.environment}-${var.domain}${var.name_discriminator}-${var.sequence}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  kind                = "OpenAI"
  sku_name            = "S0"
  tags                = local.tags

  custom_subdomain_name      = "openai"
  dynamic_throttling_enabled = false
  fqdns                      = []
  network_acls {
    default_action = "Allow"
    ip_rules       = []
  }
}

resource "azurerm_cognitive_deployment" "cognitive_deployment" {
  name                 = "gpt-4o"
  cognitive_account_id = azurerm_cognitive_account.cognitive_account.id
  rai_policy_name      = "Microsoft.DefaultV2"
  sku {
    name = "Standard"
  }
  model {
    format  = "OpenAI"
    name    = "gpt-4o"
    version = "2024-11-20"
  }
}