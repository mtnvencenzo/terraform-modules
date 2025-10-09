# Azure Container Registry Module

This module creates and configures an Azure Container Registry (ACR) with managed identity, lifecycle protection, and standardized naming conventions. It follows Azure best practices for container image storage and security.

## 🚀 Overview

The Container Registry module provides a standardized way to deploy and manage Azure Container Registries with:
- System-assigned managed identity
- Configurable SKU (Basic, Standard, Premium)
- Admin user access control
- Data endpoint configuration
- Lifecycle protection (prevent destroy)
- Standardized naming and tagging

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. Resource group created for the Container Registry

## 📦 Usage

```hcl
module "container_registry" {
  source = "git::ssh://git@github.com/mtnvencenzo/terraform-modules.git//modules/container-registry"

  # Required parameters
  resource_group_name     = "my-resource-group"
  resource_group_location = "East US"
  sub                     = "vec"
  region                  = "eus"
  environment             = "dev"
  domain                  = "myapp"
  sequence                = "001"

  # Optional parameters
  sku                   = "Standard"  # Basic, Standard, Premium
  admin_enabled         = false
  data_endpoint_enabled = false

  tags = {
    Environment = "dev"
    Project     = "MyProject"
    Purpose     = "Container Images"
  }
}
```

## 📋 Required Parameters

| Name | Type | Description |
|------|------|-------------|
| resource_group_name | string | Name of the resource group |
| resource_group_location | string | Azure region for the container registry |
| sub | string | Subscription identifier |
| region | string | Region identifier for naming |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain/application name for the registry |
| sequence | string | Sequence number for uniqueness |
| domain | string | Domain name for the container app |
| name_discriminator | string | Unique identifier for the container app |
| sequence | string | Sequence number for the container app |
| container_registry | object | Container registry configuration |
| key_vault | object | Key Vault configuration |
| container | object | Container configuration |
| secrets | list(object) | List of secrets to be used by the container app |
| env_vars | list(object) | List of environment variables |
| env_secret_vars | list(object) | List of environment variables using secrets |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| sku | string | "Standard" | Container registry SKU (Basic, Standard, Premium) |
| admin_enabled | bool | false | Enable admin user access |
| data_endpoint_enabled | bool | false | Enable data endpoint for the registry |
| tags | map(string) | {} | Tags to apply to the container registry |

## 📤 Outputs

| Name | Description |
|------|-------------|
| id | Resource ID of the container registry |
| name | Name of the created container registry |
| login_server | Login server URL for the container registry |

## 🔒 Security Features

- System-assigned managed identity
- Admin user access control
- Network access restrictions support
- Lifecycle protection (prevent destroy)
- Private endpoint support (when using Premium SKU)

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Container Registry Documentation](https://docs.microsoft.com/en-us/azure/container-registry/)

## ⚠️ Notes

- Container registry names must be globally unique across Azure
- Premium SKU is required for features like geo-replication and private endpoints
- Admin user should be disabled in production environments for better security
- Use managed identities instead of admin credentials when possible
- Consider network access restrictions for enhanced security
