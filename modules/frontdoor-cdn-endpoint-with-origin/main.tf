resource "azurerm_cdn_frontdoor_endpoint" "frontdoor_cdn_endpoint" {
    name                        = "afde-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
    cdn_frontdoor_profile_id    = var.cdn_frontdoor_profile_id

    tags = merge({
        Environment = var.environment
        Application = var.domain
    }, var.tags)
}

resource "azurerm_cdn_frontdoor_origin_group" "frontdoor_cdn_origin_group" {
    name                     = "afdog-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
    cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
    session_affinity_enabled = false

    health_probe {
        interval_in_seconds = 240
        path                = "/"
        protocol            = "Http"
        request_type        = "HEAD"
    }

    load_balancing {
        additional_latency_in_milliseconds = 0
        sample_size                        = 4
        successful_samples_required        = 2
    }
}

resource "azurerm_cdn_frontdoor_origin" "frontdoor_cdn_origin" {
  name                              = "afdo-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
  cdn_frontdoor_origin_group_id     = azurerm_cdn_frontdoor_origin_group.frontdoor_cdn_origin_group.id
  enabled                           = true
  certificate_name_check_enabled    = true
  host_name                         = var.origin_host_name
  http_port                         = 80
  https_port                        = 443
  origin_host_header                = var.origin_host_name
  priority                          = 1
  weight                            = 1000
}

resource "azurerm_cdn_frontdoor_route" "frontdoor_cdn_route" {
  name                          = "afdr-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.frontdoor_cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.frontdoor_cdn_origin_group.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.frontdoor_cdn_origin.id]

  cdn_frontdoor_rule_set_ids    = compact([
    length(var.allowed_origins) > 0 ? azurerm_cdn_frontdoor_rule_set.frontdoor_cdn_cors_ruleset[0].id : null,
    var.caching_rule != null ? azurerm_cdn_frontdoor_rule_set.frontdoor_cdn_caching_ruleset[0].id : null
  ])

  enabled                 = true
  forwarding_protocol     = "MatchRequest"
  https_redirect_enabled  = false
  patterns_to_match       = ["/*"]
  supported_protocols     = ["Https"]

  link_to_default_domain          = var.custom_domain == null ? true : false
  cdn_frontdoor_custom_domain_ids = var.custom_domain == null ? [] : [azurerm_cdn_frontdoor_custom_domain.frontdoor_cdn_custom_domain[0].id]

  cache {
    query_string_caching_behavior   = "UseQueryString"
    compression_enabled             = true
    content_types_to_compress = [
      "application/eot",
      "application/font",
      "application/javascript",
      "application/json",
      "application/xml",
      "image/svg+xml",
      "text/css",
      "text/csv",
      "text/html",
      "text/javascript",
      "text/plain",
      "text/xml"
    ]
  }
}

