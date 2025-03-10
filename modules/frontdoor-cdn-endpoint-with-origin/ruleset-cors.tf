resource "azurerm_cdn_frontdoor_rule_set" "frontdoor_cdn_cors_ruleset" {
  count                     = length(var.allowed_origins) > 0 ? 1 : 0
  name                      = "${var.environment}${var.domain}cors"
  cdn_frontdoor_profile_id  = var.cdn_frontdoor_profile_id
}

resource "azurerm_cdn_frontdoor_rule" "frontdoor_cdn_cors_ruleset_origin_rules" {
  for_each                      = toset(var.allowed_origins)

  name                          = "originrule${index(var.allowed_origins, each.value)}"
  cdn_frontdoor_rule_set_id     = azurerm_cdn_frontdoor_rule_set.frontdoor_cdn_cors_ruleset.id
  order                         = 1
  behavior_on_match             = "Stop"

  conditions {
    request_header_condition {
      header_name = "Origin"
      operator = "Equal"
      match_values = [lower(each.value)]
      transforms = ["Lowercase"]
    }
  }

  actions {
    response_header_action {
      header_action = "Overwrite"
      header_name = "Access-Control-Allow-Origin"
      value = lower(each.value)
    }

    response_header_action {
      header_action = "Overwrite"
      header_name = "Access-Control-Allow-Methods"
      value = "GET, HEAD, OPTIONS"
    }

    response_header_action {
      header_action = "Overwrite"
      header_name = "Access-Control-Allow-Headers"
      value = "*"
    }

    response_header_action {
      header_action = "Overwrite"
      header_name = "Access-Control-Expose-Headers"
      value = "*"
    }
  }

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.frontdoor_cdn_origin_group,
    azurerm_cdn_frontdoor_origin.frontdoor_cdn_origin
  ]
}