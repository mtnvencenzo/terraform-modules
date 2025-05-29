# Azure Cosmos DB Account Module

This module creates and configures an Azure Cosmos DB Account with private networking, custom consistency, custom roles, and monitoring alerts. It follows Azure best practices for distributed database deployment and security.

## 🚀 Overview

The Cosmos DB Account module provides a standardized way to deploy and manage globally distributed, multi-model databases with:
- Private networking integration
- Custom consistency policies
- Geo-redundancy
- Custom RBAC roles
- Automated monitoring alerts
- Prevent destroy lifecycle

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. Virtual network and subnet IDs for private access
4. Action group for alerting (optional)

## 📦 Usage

```hcl
module "cosmos_db_account" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/cosmos-db-account"

  # Required parameters
  resource_group_name    = "my-resource-group"
  location              = "eastus"
  environment           = "dev"
  domain                = "myapp"
  sequence              = "001"
  sub                   = "myapp"
  region                = "eastus"
  subnet_ids            = ["/subscriptions/.../subnets/cosmos-subnet"]
  geo_location          = "westus"
  consistency_level     = "Session"
  max_interval_in_seconds = 5
  max_staleness_prefix  = 100

  # Monitoring
  enable_monitor_alerts = true
  action_group_id       = "/subscriptions/.../resourceGroups/.../providers/microsoft.insights/actionGroups/..."

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
| location | string | Azure region for the account |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the account |
| sequence | string | Sequence number for the account |
| sub | string | Subscription identifier |
| region | string | Region identifier |
| subnet_ids | list(string) | List of subnet IDs for private access |
| geo_location | string | Secondary geo location |
| consistency_level | string | Consistency level (e.g., Session, Strong) |
| max_interval_in_seconds | number | Max interval for consistency |
| max_staleness_prefix | number | Max staleness prefix for consistency |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| enable_monitor_alerts | bool | false | Enable monitoring alerts |
| action_group_id | string | null | Action group for alerts |
| tags | map(string) | {} | Tags to apply to the account |

## 📤 Outputs

| Name | Description |
|------|-------------|
| account_name | Name of the created Cosmos DB account |
| account_id | Resource ID of the account |
| endpoint | Endpoint URL of the account |
| custom_role_ids | IDs of the custom roles |

## 🔒 Security Features

- Private networking
- Custom RBAC roles
- Prevent destroy lifecycle
- Monitoring alerts for RU usage
- Consistency policy enforcement

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Cosmos DB Documentation](https://docs.microsoft.com/en-us/azure/cosmos-db/introduction)

## ⚠️ Notes

- Account names must be globally unique
- Review consistency and geo-redundancy settings for your needs
- Use private endpoints for enhanced security
- Custom roles can be assigned to users or applications
- Alerts help monitor RU consumption and avoid throttling
- The module prevents accidental destruction of the account
