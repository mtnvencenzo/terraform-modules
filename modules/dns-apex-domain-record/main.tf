resource "azurerm_dns_txt_record" "dns_apex_domain_txt_verification_record" {
  name                = "asuid"
  zone_name           = var.dns_zone.name
  resource_group_name = var.dns_zone.resource_group_name
  ttl                 = var.ttl

  tags = var.tags

  record {
    value = lower(var.custom_domain_verification_id)
  }
}

resource "null_resource" "dns_apex_domain_txt_verification_record_previous" {}

resource "time_sleep" "dns_apex_domain_txt_verification_record_wait_30_seconds" {
  create_duration     = "30s"
  depends_on          = [null_resource.dns_apex_domain_txt_verification_record_previous]
}

resource "null_resource" "dns_apex_domain_txt_verification_record_continuation" {
  depends_on          = [time_sleep.dns_apex_domain_txt_verification_record_wait_30_seconds]
}

resource "azurerm_dns_a_record" "dns_apex_domain_a_record" {
  name                = "@"
  zone_name           = var.dns_zone.name
  resource_group_name = var.dns_zone.resource_group_name
  ttl                 = var.ttl
  records             = [var.host_ip_address]

  tags = var.tags

  depends_on = [
    azurerm_dns_txt_record.dns_apex_domain_txt_verification_record,
    null_resource.dns_apex_domain_txt_verification_record_continuation
  ]
}


