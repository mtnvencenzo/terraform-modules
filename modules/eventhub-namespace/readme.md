# Azure Event Hub Namespace Module

This module creates and configures an Azure Event Hub Namespace with private networking, auto-inflate, and security best practices. It follows Azure best practices for event streaming and real-time analytics.

## 🚀 Overview

The Event Hub Namespace module provides a standardized way to deploy and manage namespaces for event streaming with:
- Private networking
- Auto-inflate and throughput scaling
- Tagging and environment metadata
- Prevent destroy lifecycle

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. Virtual network and subnet IDs for private access

## 📦 Usage

```hcl
module "eventhub_namespace" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/eventhub-namespace"

  # Required parameters
  resource_group_name    = "my-resource-group"
  location              = "eastus"
  environment           = "dev"
  domain                = "myapp"
  sequence              = "001"
  sub                   = "myapp"
  region                = "eastus"
  subnet_ids            = ["/subscriptions/.../subnets/eventhub-subnet"]

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
| subnet_ids | list(string) | List of subnet IDs for private access |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| tags | map(string) | {} | Tags to apply to the namespace |

## 📤 Outputs

| Name | Description |
|------|-------------|
| namespace_name | Name of the created Event Hub namespace |
| namespace_id | Resource ID of the namespace |

## 🔒 Security Features

- Private networking
- Auto-inflate for scaling
- Prevent destroy lifecycle

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Event Hub Documentation](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-about)

## ⚠️ Notes

- Namespace names must be globally unique
- Use private endpoints for enhanced security
- Review throughput and scaling settings for your needs
- The module prevents accidental destruction of the namespace
