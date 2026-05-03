# Azure Service Bus Subscription Rule Module

This module creates and configures an Azure Service Bus Subscription Rule with correlation filter settings. It follows Azure best practices for rule deployment and security.

## 🚀 Overview

The Service Bus Subscription Rule module provides a standardized way to deploy and manage subscription rules with:
- Rule configuration
- Correlation filter settings
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing Service Bus Subscription

## 📦 Usage

```hcl
module "servicebus_subscription_rule" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/servicebus-subscription-rule"

  # Required parameters
  subscription_id = "my-subscription-id"
  correlation_filter_label = "my-label"

  tags = {
    Environment = "dev"
    Project     = "MyProject"
  }
}
```

## 📋 Required Parameters

| Name | Type | Description |
|------|------|-------------|
| subscription_id | string | ID of the Service Bus Subscription |
| correlation_filter_label | string | Label for the correlation filter |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| tags | map(string) | {} | Tags to apply to the subscription rule |

## 📤 Outputs

| Name | Description |
|------|-------------|
| rule_name | Name of the created Service Bus Subscription Rule |
| rule_id | Resource ID of the rule |

## 🔒 Security Features

- Correlation filter settings
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Service Bus Documentation](https://docs.microsoft.com/en-us/azure/service-bus-messaging/)

## ⚠️ Notes

- Rule names must be unique within the Service Bus Subscription
- Review correlation filter settings for your environment
- Consider using private endpoints for enhanced security
