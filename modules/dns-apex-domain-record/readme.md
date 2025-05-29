# Azure DNS Apex Domain Record Module

This module creates and configures an Azure DNS Apex Domain Record with TXT verification and A record settings. It follows Azure best practices for DNS deployment and security.

## 🚀 Overview

The DNS Apex Domain Record module provides a standardized way to deploy and manage DNS records with:
- TXT verification records
- A record configuration
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing DNS zone

## 📦 Usage

```hcl
module "dns_apex_domain_record" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/dns-apex-domain-record"

  # Required parameters
  dns_zone = {
    name                = "myzone.com"
    resource_group_name = "my-resource-group"
  }
  custom_domain_verification_id = "verification-id"
  host_ip_address              = "192.168.1.1"
  ttl                          = 3600

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
| custom_domain_verification_id | string | Verification ID for the custom domain |
| host_ip_address | string | IP address for the A record |
| ttl | number | Time to live for the DNS records |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| tags | map(string) | {} | Tags to apply to the DNS records |

## 📤 Outputs

| Name | Description |
|------|-------------|
| txt_record_name | Name of the created TXT record |
| a_record_name | Name of the created A record |

## 🔒 Security Features

- TXT verification records
- A record configuration
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure DNS Documentation](https://docs.microsoft.com/en-us/azure/dns/)

## ⚠️ Notes

- DNS record names must be unique within the DNS zone
- Review TXT verification settings for your environment
- Ensure A record configurations are properly set up
- Consider using private endpoints for enhanced security
