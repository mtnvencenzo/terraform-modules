# Azure Email Communication Service Module

This module creates and configures an Azure Email Communication Service with domain verification and email sending capabilities. It follows Azure best practices for email service deployment and security.

## 🚀 Overview

The Email Communication Service module provides a standardized way to deploy and manage email services with:
- Domain verification
- Email sending configuration
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. DNS zone for domain verification

## 📦 Usage

```hcl
module "email_communication_service" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/email-communication-service"

  # Required parameters
  resource_group_name    = "my-resource-group"
  location              = "eastus"
  environment           = "dev"
  domain                = "myapp"
  sequence              = "001"
  sub                   = "myapp"
  region                = "eastus"

  # Domain verification
  dns_zone = {
    name                = "myzone.com"
    resource_group_name = "my-resource-group"
  }

  tags = {
    Environment = "dev"
    Project     = "MyProject"
  }
}
```

## 📋 Required Parameters

| Name | Type | Description |
|------|------|-------------|
| resource_group_name | string | Name of the resource group |
| location | string | Azure region for the service |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the service |
| sequence | string | Sequence number for the service |
| sub | string | Subscription identifier |
| region | string | Region identifier |
| dns_zone | object | DNS zone configuration for domain verification |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| tags | map(string) | {} | Tags to apply to the service |

## 📤 Outputs

| Name | Description |
|------|-------------|
| service_name | Name of the created Email Communication Service |
| service_id | Resource ID of the service |

## 🔒 Security Features

- Domain verification
- Email sending configuration
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Communication Services Documentation](https://docs.microsoft.com/en-us/azure/communication-services/)

## ⚠️ Notes

- Service names must be globally unique
- Domain verification is required for sending emails
- Review email sending settings for your environment
- Consider using private endpoints for enhanced security
