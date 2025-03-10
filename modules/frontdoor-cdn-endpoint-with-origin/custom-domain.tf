
resource "azurerm_cdn_frontdoor_custom_domain" "frontdoor_cdn_custom_domain" {
  count                     = var.custom_domain == null ? 0 : 1
  name                      = replace(var.custom_domain.host_name, ".", "-")
  cdn_frontdoor_profile_id  = var.cdn_frontdoor_profile_id
  dns_zone_id               = var.custom_domain.dns_zone_id
  host_name                 = var.custom_domain.host_name

  tls {
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "frontdoor_cdn_custom_domain_route_association" {
  count                           = var.custom_domain == null ? 0 : 1
  cdn_frontdoor_custom_domain_id  = azurerm_cdn_frontdoor_custom_domain.frontdoor_cdn_custom_domain[0].id
  cdn_frontdoor_route_ids         = [azurerm_cdn_frontdoor_route.frontdoor_cdn_route.id]
}


# ================================
# CDN SUB DOMAIN
# ================================
module "cocktails_cdn_dns_sub_domain_record" {
  source                          = "../dns-sub-domain-record"
  custom_domain_verification_id   = azurerm_cdn_frontdoor_custom_domain.frontdoor_cdn_custom_domain.validation_token
  custom_domain_verification_name = "_dnsauth.${var.custom_domain.sub_domain}"
  sub_domain                      = var.custom_domain.sub_domain
  record_fqdn                     = azurerm_cdn_frontdoor_endpoint.frontdoor_cdn_endpoint.host_name

  dns_zone = {
    name                = var.custom_domain.dns_zone_name
    resource_group_name = var.custom_domain.dns_zone_resource_group
  }

  providers = {
      azurerm = azurerm
  }
}
