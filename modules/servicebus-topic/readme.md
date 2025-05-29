# Azure Service Bus Topic Module

This module creates and configures an Azure Service Bus Topic with features such as duplicate detection and ordering support. It follows Azure best practices for topic deployment and security.

## 🚀 Overview

The Service Bus Topic module provides a standardized way to deploy and manage topics with:
- Topic configuration
- Duplicate detection
- Ordering support
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing Service Bus Namespace

## 📦 Usage

```hcl
module "servicebus_topic" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/servicebus-topic"

  # Required parameters
  namespace_id = "my-namespace-id"
  sub          = "myapp"
  region       = "eastus"
  environment  = "dev"
  domain       = "myapp"
  name_discriminator = "topic"
  sequence     = "001"

  # Optional parameters
  requires_duplicate_detection                = true
  duplicate_detection_history_time_window     = "PT10M"
  support_ordering                            = true

  tags = {
    Environment = "dev"
    Project     = "MyProject"
  }
}
```

## 📋 Required Parameters

| Name | Type | Description |
|------|------|-------------|
| namespace_id | string | ID of the Service Bus Namespace |
| sub | string | Subscription identifier |
| region | string | Azure region for the topic |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the topic |
| name_discriminator | string | Unique identifier for the topic |
| sequence | string | Sequence number for the topic |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| requires_duplicate_detection | bool | false | Enable duplicate detection |
| duplicate_detection_history_time_window | string | "PT10M" | Time window for duplicate detection |
| support_ordering | bool | false | Enable ordering support |
| tags | map(string) | {} | Tags to apply to the topic |

## 📤 Outputs

| Name | Description |
|------|-------------|
| topic_name | Name of the created Service Bus Topic |
| topic_id | Resource ID of the topic |

## 🔒 Security Features

- Duplicate detection
- Ordering support
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Service Bus Documentation](https://docs.microsoft.com/en-us/azure/service-bus-messaging/)

## ⚠️ Notes

- Topic names must be unique within the Service Bus Namespace
- Review duplicate detection settings for your environment
- Ensure ordering support is configured as needed
- Consider using private endpoints for enhanced security
