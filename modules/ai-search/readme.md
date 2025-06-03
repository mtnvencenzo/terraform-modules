# Azure AI Search Module

This module creates and configures an Azure AI Search service (formerly Azure Cognitive Search) with customizable settings for scaling and security. It follows Azure best practices for search service deployment.

## 🚀 Overview

The Azure AI Search module provides a standardized way to deploy and manage search services with:
- Configurable SKU selection (defaults to Free tier)
- Adjustable replica and partition counts
- Network access controls
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. Appropriate permissions to create search services

## 📦 Usage

```hcl
module "ai_search" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/ai-search"

  # Required parameters
  resource_group_name = "my-resource-group"
  location            = "East US"
  environment         = "dev"
  domain              = "myapp"
  sequence            = "001"
  sub                 = "myapp"
  region              = "eus"

  # Optional parameters
  sku                       = "free"  # Options: free, basic, standard, standard2, standard3
  replica_count             = 1
  partition_count           = 1
  public_network_access_enabled = true

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

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| sku | string | "free" | SKU for the search service |
| replica_count | number | 1 | Number of replicas |
| partition_count | number | 1 | Number of partitions |
| public_network_access_enabled | bool | true | Whether public network access is allowed |
| tags | map(string) | {} | Tags to apply to the service |

## 📤 Outputs

| Name | Description |
|------|-------------|
| search_service_name | Name of the created search service |
| search_service_id | Resource ID of the service |
| search_service_primary_key | Primary key of the service (sensitive) |
| search_service_secondary_key | Secondary key of the service (sensitive) |
| search_service_identity | Managed identity of the service |

## 🔒 Security Features

- Configurable network access
- System-assigned managed identity
- Secure key management
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure AI Search Documentation](https://docs.microsoft.com/en-us/azure/search/)

## ⚠️ Notes

- Free tier has limitations on scale and features
- Consider using private endpoints for enhanced security
- Review SKU selection based on your workload requirements
- Monitor replica and partition counts for optimal performance 