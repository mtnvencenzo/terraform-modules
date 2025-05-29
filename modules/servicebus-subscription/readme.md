# Azure Service Bus Subscription Module

This module creates and configures an Azure Service Bus Subscription with features such as message forwarding and delivery count settings. It follows Azure best practices for subscription deployment and security.

## 🚀 Overview

The Service Bus Subscription module provides a standardized way to deploy and manage subscriptions with:
- Subscription configuration
- Message forwarding
- Delivery count settings
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing Service Bus Topic

## 📦 Usage

```hcl
module "servicebus_subscription" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/servicebus-subscription"

  # Required parameters
  topic_id = "my-topic-id"
  sub      = "myapp"
  region   = "eastus"
  environment = "dev"
  domain   = "myapp"
  name_discriminator = "subscription"
  sequence = "001"

  # Optional parameters
  max_delivery_count = 10
  forward_to        = "my-forward-queue"

  tags = {
    Environment = "dev"
    Project     = "MyProject"
  }
}
```

## 📋 Required Parameters

| Name | Type | Description |
|------|------|-------------|
| topic_id | string | ID of the Service Bus Topic |
| sub | string | Subscription identifier |
| region | string | Azure region for the subscription |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the subscription |
| name_discriminator | string | Unique identifier for the subscription |
| sequence | string | Sequence number for the subscription |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| max_delivery_count | number | 10 | Maximum number of delivery attempts |
| forward_to | string | null | Queue or topic to forward messages to |
| tags | map(string) | {} | Tags to apply to the subscription |

## 📤 Outputs

| Name | Description |
|------|-------------|
| subscription_name | Name of the created Service Bus Subscription |
| subscription_id | Resource ID of the subscription |

## 🔒 Security Features

- Message forwarding
- Delivery count settings
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Service Bus Documentation](https://docs.microsoft.com/en-us/azure/service-bus-messaging/)

## ⚠️ Notes

- Subscription names must be unique within the Service Bus Topic
- Review message forwarding settings for your environment
- Ensure delivery count settings are configured as needed
- Consider using private endpoints for enhanced security
