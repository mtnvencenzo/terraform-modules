resource "azurerm_dns_mx_record" "dns_mx_record" {
  name                = "@"
  zone_name           = var.dns_zone.name
  resource_group_name = var.dns_zone.resource_group_name
  ttl                 = var.ttl

  dynamic "record" {
    for_each = toset(var.record_exchanges)

    content {
      preference  = record.value["preference"]
      exchange    = record.value["exchange"]
    }
  }
}

resource "azurerm_dns_txt_record" "dns_mx_spf_record" {
  name                = "@"
  zone_name           = var.dns_zone.name
  resource_group_name = var.dns_zone.resource_group_name
  ttl                 = var.ttl

  record {
    value = "v=spf1 include:${var.spf_include_domain} ~all"
  }
}

resource "azurerm_dns_txt_record" "dns_mx_dkim_record" {
  name                = var.dkim_record.name
  zone_name           = var.dns_zone.name
  resource_group_name = var.dns_zone.resource_group_name
  ttl                 = var.ttl

  record {
    value = var.dkim_record.value
  }
}