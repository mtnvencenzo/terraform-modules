# Azure DNS TXT Record Module

This module creates and configures an Azure DNS TXT Record with specified values. It follows Azure best practices for DNS deployment and security.

## 🚀 Overview

The DNS TXT Record module provides a standardized way to deploy and manage TXT records with:
- TXT record configuration
- Value settings
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing DNS zone

## 📦 Usage

```hcl
module "dns_txt_record" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/dns-txt-record"

  # Required parameters
  dns_zone = {
    name                = "myzone.com"
    resource_group_name = "my-resource-group"
  }
  name = "my-txt-record"
  value = "v=spf1 include:myzone.com ~all"
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
| name | string | Name of the TXT record |
| value | string | Value for the TXT record |
| ttl | number | Time to live for the DNS record |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| tags | map(string) | {} | Tags to apply to the DNS record |

## 📤 Outputs

| Name | Description |
|------|-------------|
| txt_record_name | Name of the created TXT record |

## 🔒 Security Features

- TXT record configuration
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure DNS Documentation](https://docs.microsoft.com/en-us/azure/dns/)

## ⚠️ Notes

- DNS record names must be unique within the DNS zone
- Review TXT record values for your environment
- Consider using private endpoints for enhanced security
