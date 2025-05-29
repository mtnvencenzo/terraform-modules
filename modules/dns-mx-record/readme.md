# Azure DNS MX Record Module

This module creates and configures an Azure DNS MX Record with SPF and DKIM settings. It follows Azure best practices for DNS deployment and security.

## 🚀 Overview

The DNS MX Record module provides a standardized way to deploy and manage MX records with:
- MX record configuration
- SPF record settings
- DKIM record settings
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing DNS zone

## 📦 Usage

```hcl
module "dns_mx_record" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/dns-mx-record"

  # Required parameters
  dns_zone = {
    name                = "myzone.com"
    resource_group_name = "my-resource-group"
  }
  record_exchanges = [
    {
      preference = 10
      exchange   = "mail.myzone.com"
    }
  ]
  spf_include_domain = "myzone.com"
  dkim_record = {
    name  = "selector"
    value = "v=DKIM1; k=rsa; p=your-public-key"
  }
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
| record_exchanges | list(object) | List of MX record exchanges |
| spf_include_domain | string | Domain to include in SPF record |
| dkim_record | object | DKIM record configuration |
| ttl | number | Time to live for the DNS records |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| tags | map(string) | {} | Tags to apply to the DNS records |

## 📤 Outputs

| Name | Description |
|------|-------------|
| mx_record_name | Name of the created MX record |
| spf_record_name | Name of the created SPF record |
| dkim_record_name | Name of the created DKIM record |

## 🔒 Security Features

- MX record configuration
- SPF record settings
- DKIM record settings
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure DNS Documentation](https://docs.microsoft.com/en-us/azure/dns/)

## ⚠️ Notes

- DNS record names must be unique within the DNS zone
- Review MX record settings for your environment
- Ensure SPF and DKIM configurations are properly set up
- Consider using private endpoints for enhanced security
