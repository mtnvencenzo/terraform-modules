# Azure Service Bus Namespace Module

This module creates and configures an Azure Service Bus Namespace with private networking, managed identity, and security best practices. It follows Azure best practices for messaging and event-driven architectures.

## 🚀 Overview

The Service Bus Namespace module provides a standardized way to deploy and manage namespaces for messaging with:
- Private networking (optional)
- Managed identity integration
- TLS 1.2 enforcement
- Tagging and environment metadata
- Prevent destroy lifecycle

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. Virtual network and subnet IDs (if using private networking)

## 📦 Usage

```hcl
module "servicebus_namespace" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/servicebus-namespace"

  # Required parameters
  resource_group_name    = "my-resource-group"
  location              = "eastus"
  environment           = "dev"
  domain                = "myapp"
  sequence              = "001"
  sub                   = "myapp"
  region                = "eastus"

  # Optional networking
  public_network_access_enabled = false
  local_auth_enabled           = false
  subnet_ids                   = ["/subscriptions/.../subnets/servicebus-subnet"]

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
| location | string | Azure region for the namespace |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the namespace |
| sequence | string | Sequence number for the namespace |
| sub | string | Subscription identifier |
| region | string | Region identifier |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| public_network_access_enabled | bool | false | Enable public network access |
| local_auth_enabled | bool | false | Enable local authentication |
| subnet_ids | list(string) | [] | List of subnet IDs for private access |
| tags | map(string) | {} | Tags to apply to the namespace |

## 📤 Outputs

| Name | Description |
|------|-------------|
| namespace_name | Name of the created Service Bus namespace |
| namespace_id | Resource ID of the namespace |

## 🔒 Security Features

- Managed identity integration
- TLS 1.2 enforcement
- Private networking (optional)
- Prevent destroy lifecycle

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Service Bus Documentation](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview)

## ⚠️ Notes

- Namespace names must be globally unique
- Use private endpoints for enhanced security
- Review network and authentication settings for your needs
- The module prevents accidental destruction of the namespace
