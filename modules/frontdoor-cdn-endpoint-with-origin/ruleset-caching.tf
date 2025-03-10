resource "azurerm_cdn_frontdoor_rule_set" "frontdoor_cdn_caching_ruleset" {
  count                     = var.caching_rule != null ? 1 : 0
  name                      = "${var.environment}${var.domain}caching"
  cdn_frontdoor_profile_id  = var.cdn_frontdoor_profile_id
}

resource "azurerm_cdn_frontdoor_rule" "frontdoor_cdn_caching_ruleset_caching_rule" {
  count                       = var.caching_rule != null ? 1 : 0
  name                        = "route-config-override-caching-rule"
  cdn_frontdoor_rule_set_id   = azurerm_cdn_frontdoor_rule_set.frontdoor_cdn_caching_ruleset[0].id
  order                       = 1
  behavior_on_match           = "Continue"

  actions {
    dynamic "route_configuration_override_action" {
      for_each = var.caching_rule != null ? [0] : []

      content {
        query_string_caching_behavior   = var.caching_rule.ignore_query_strings == true ? "IgnoreQueryString" : "UseQueryString"
        cache_behavior                  = "OverrideAlways"
        cache_duration                  = var.caching_rule.cache_duration != null ? var.caching_rule.cache_duration : "60.00:00:00"
        compression_enabled             = var.caching_rule.compression_enabled == false ? false : true
      }
    }
  }

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.frontdoor_cdn_origin_group,
    azurerm_cdn_frontdoor_origin.frontdoor_cdn_origin
  ]
}