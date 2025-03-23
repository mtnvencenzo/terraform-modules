resource "azurerm_dns_txt_record" "dns_txt_record" {
  name                = var.name
  zone_name           = var.dns_zone.name
  resource_group_name = var.dns_zone.resource_group_name
  ttl                 = var.ttl

  tags = var.tags

  record {
    value = lower(var.value)
  }
}