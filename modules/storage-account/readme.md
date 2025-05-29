# Azure Storage Account Module

This module creates and configures an Azure Storage Account with blob containers, CORS rules, and security best practices. It follows Azure best practices for storage deployment and security.

## 🚀 Overview

The Storage Account module provides a standardized way to deploy and manage storage accounts with:
- Blob container creation
- CORS configuration
- HTTPS-only traffic
- TLS 1.2 enforcement
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. Resource group created

## 📦 Usage

```hcl
module "storage_account" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/storage-account"

  # Required parameters
  resource_group_name    = "my-resource-group"
  resource_group_location = "eastus"
  environment           = "dev"
  domain                = "myapp"
  name_discriminator    = "storage"
  short_sequence        = "001"
  sub                   = "myapp"

  # Blob containers
  blob_containers = [
    {
      name                = "container1"
      container_access_type = "private"
    },
    {
      name                = "container2"
      container_access_type = "blob"
    }
  ]

  # CORS configuration
  allowed_origins = ["https://myapp.com"]

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
| resource_group_location | string | Azure region for the storage account |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the storage account |
| name_discriminator | string | Unique identifier for the storage account |
| short_sequence | string | Sequence number for the storage account |
| sub | string | Subscription identifier |
| blob_containers | list(object) | List of blob containers to create |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| allowed_origins | list(string) | [] | List of allowed CORS origins |
| tags | map(string) | {} | Tags to apply to the storage account |

## 📤 Outputs

| Name | Description |
|------|-------------|
| storage_account_name | Name of the created storage account |
| storage_account_id | Resource ID of the storage account |
| container_names | Names of the created blob containers |

## 🔒 Security Features

- HTTPS-only traffic
- TLS 1.2 enforcement
- CORS configuration
- Private container access types

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Storage Documentation](https://docs.microsoft.com/en-us/azure/storage/common/storage-introduction)

## ⚠️ Notes

- Storage account names must be globally unique
- Review CORS settings for your environment
- Consider using private endpoints for enhanced security
- Container access types affect public access
