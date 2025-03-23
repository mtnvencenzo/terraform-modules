resource "azurerm_dns_txt_record" "dns_sub_domain_txt_verification_record" {
  name                = var.custom_domain_verification_name != null ? var.custom_domain_verification_name : "asuid.${var.sub_domain}"
  zone_name           = var.dns_zone.name
  resource_group_name = var.dns_zone.resource_group_name
  ttl                 = var.ttl
  tags                = var.tags

  record {
    value = var.custom_domain_verification_id
  }
}

resource "null_resource" "dns_sub_domain_txt_verification_record_previous" {}

resource "time_sleep" "dns_sub_domain_txt_verification_record_wait_30_seconds" {
  create_duration     = "30s"
  depends_on          = [null_resource.dns_sub_domain_txt_verification_record_previous]
}

resource "null_resource" "dns_sub_domain_txt_verification_record_continuation" {
  depends_on          = [time_sleep.dns_sub_domain_txt_verification_record_wait_30_seconds]
}

resource "azurerm_dns_cname_record" "dns_sub_domain_sname_record" {
  name                = var.sub_domain
  zone_name           = var.dns_zone.name
  resource_group_name = var.dns_zone.resource_group_name
  ttl                 = var.ttl
  record              = var.record_fqdn
  tags                = var.tags

  depends_on = [
    azurerm_dns_txt_record.dns_sub_domain_txt_verification_record,
    null_resource.dns_sub_domain_txt_verification_record_continuation
  ]
}

