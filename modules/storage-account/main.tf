resource "azurerm_storage_account" "storage_account" {
  name							    = "st${var.sub}${var.environment}${var.domain}${var.name_discriminator}${var.short_sequence}"
  resource_group_name			    = var.resource_group_name
  location						    = var.resource_group_location
  account_tier						= "Standard"
  account_replication_type		    = "LRS"
  allow_nested_items_to_be_public   = true
  cross_tenant_replication_enabled  = false
  access_tier					    = "Hot"
  https_traffic_only_enabled        = true
  min_tls_version				    = "TLS1_2"
  public_network_access_enabled	    = true
  tags = {
      Environment = var.environment
      Application = var.domain
  }

  blob_properties {
    cors_rule{
      allowed_headers = ["*"]
      allowed_methods = ["GET","OPTIONS"]
      allowed_origins = var.allowed_origins
      exposed_headers = ["*"]
      max_age_in_seconds = 86400
    }
  }
}

resource "azurerm_storage_container" "blob_containers" {
  for_each = tomap({
    for container in var.blob_containers :
      contaner.name => container
  })

  name = each.value.name
  storage_account_name    = azurerm_storage_account.storage_account.name
  container_access_type   = "blob"

  depends_on = [ 
    azurerm_storage_account.storage_account
  ]
}