# Azure Communication Service Module

This module creates and configures an Azure Communication Service with data location settings and lifecycle management. It follows Azure best practices for communication services and security.

## 🚀 Overview

The Communication Service module provides a standardized way to deploy and manage communication services with:
- Service configuration
- Data location settings
- Lifecycle management
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. A resource group for the service

## 📦 Usage

```hcl
module "communication_service" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/communication-service"

  # Required parameters
  resource_group_name = "my-resource-group"
  sub                = "myapp"
  region             = "eastus"
  environment        = "dev"
  domain             = "myapp"
  sequence           = "001"
  data_location      = "United States"

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
| sub | string | Subscription identifier |
| region | string | Azure region for the service |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the service |
| sequence | string | Sequence number for the service |
| data_location | string | Data location for the service |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| tags | map(string) | {} | Tags to apply to the service |

## 📤 Outputs

| Name | Description |
|------|-------------|
| service_name | Name of the created Communication Service |
| service_id | Resource ID of the service |

## 🔒 Security Features

- Data location configuration
- Lifecycle management
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Communication Services Documentation](https://docs.microsoft.com/en-us/azure/communication-services/)

## ⚠️ Notes

- Service names must be unique within the subscription
- Review data location settings for compliance requirements
- The service has prevent_destroy lifecycle rule enabled
- Consider using private endpoints for enhanced security
- Monitor service usage and adjust settings as needed
