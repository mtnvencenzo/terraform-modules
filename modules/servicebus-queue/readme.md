# Azure Service Bus Queue Module

This module creates and configures an Azure Service Bus Queue with features such as duplicate detection, session support, and dead lettering. It follows Azure best practices for queue deployment and security.

## 🚀 Overview

The Service Bus Queue module provides a standardized way to deploy and manage queues with:
- Queue configuration
- Duplicate detection
- Session support
- Dead lettering
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing Service Bus Namespace

## 📦 Usage

```hcl
module "servicebus_queue" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/servicebus-queue"

  # Required parameters
  namespace_id = "my-namespace-id"
  sub          = "myapp"
  region       = "eastus"
  environment  = "dev"
  domain       = "myapp"
  name_discriminator = "queue"
  sequence     = "001"

  # Optional parameters
  lock_duration                               = "PT5M"
  requires_duplicate_detection                = true
  duplicate_detection_history_time_window     = "PT10M"
  requires_session                            = true
  dead_lettering_on_message_expiration        = true
  max_delivery_count                          = 10

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
| region | string | Azure region for the queue |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the queue |
| name_discriminator | string | Unique identifier for the queue |
| sequence | string | Sequence number for the queue |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| lock_duration | string | "PT5M" | Duration for which a message is locked |
| requires_duplicate_detection | bool | false | Enable duplicate detection |
| duplicate_detection_history_time_window | string | "PT10M" | Time window for duplicate detection |
| requires_session | bool | false | Enable session support |
| dead_lettering_on_message_expiration | bool | false | Enable dead lettering on message expiration |
| max_delivery_count | number | 10 | Maximum number of delivery attempts |
| tags | map(string) | {} | Tags to apply to the queue |

## 📤 Outputs

| Name | Description |
|------|-------------|
| queue_name | Name of the created Service Bus Queue |
| queue_id | Resource ID of the queue |

## 🔒 Security Features

- Duplicate detection
- Session support
- Dead lettering
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Service Bus Documentation](https://docs.microsoft.com/en-us/azure/service-bus-messaging/)

## ⚠️ Notes

- Queue names must be unique within the Service Bus Namespace
- Review duplicate detection settings for your environment
- Ensure session support is configured as needed
- Consider using private endpoints for enhanced security
