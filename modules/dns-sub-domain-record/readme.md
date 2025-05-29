# Azure DNS Subdomain Record Module

This module creates and configures an Azure DNS Subdomain Record with TXT verification and CNAME record settings. It follows Azure best practices for DNS deployment and security.

## 🚀 Overview

The DNS Subdomain Record module provides a standardized way to deploy and manage subdomain records with:
- TXT verification records
- CNAME record configuration
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing DNS zone

## 📦 Usage

```hcl
module "dns_sub_domain_record" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/dns-sub-domain-record"

  # Required parameters
  dns_zone = {
    name                = "myzone.com"
    resource_group_name = "my-resource-group"
  }
  sub_domain = "sub"
  custom_domain_verification_id = "verification-id"
  record_fqdn = "myapp.azurewebsites.net"
  ttl = 3600

  tags = {
    Environment = "dev"
    Project     = "MyProject"
  }
}
```

## 📋 Required Parameters

| Name | Type | Description |
|------|------|-------------|
| dns_zone | object | DNS zone configuration |
| sub_domain | string | Name of the subdomain |
| custom_domain_verification_id | string | Verification ID for the custom domain |
| record_fqdn | string | FQDN for the CNAME record |
| ttl | number | Time to live for the DNS records |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| custom_domain_verification_name | string | null | Custom name for the TXT verification record |
| tags | map(string) | {} | Tags to apply to the DNS records |

## 📤 Outputs

| Name | Description |
|------|-------------|
| txt_record_name | Name of the created TXT record |
| cname_record_name | Name of the created CNAME record |

## 🔒 Security Features

- TXT verification records
- CNAME record configuration
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure DNS Documentation](https://docs.microsoft.com/en-us/azure/dns/)

## ⚠️ Notes

- DNS record names must be unique within the DNS zone
- Review TXT verification settings for your environment
- Ensure CNAME record configurations are properly set up
- Consider using private endpoints for enhanced security
