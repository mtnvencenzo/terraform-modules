# Azure Storage Container Module

This module creates and configures an Azure Storage Container with RBAC role assignments. It follows Azure best practices for container access and security.

## 🚀 Overview

The Storage Container module provides a standardized way to deploy and manage storage containers with:
- Configurable container access types
- RBAC role assignments
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing storage account

## 📦 Usage

```hcl
module "storage_container" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/storage-container"

  # Required parameters
  container_name       = "mycontainer"
  storage_account_name = "mystorageaccount"
  container_access_type = "private"

  # RBAC role assignments
  role_assignments = [
    {
      role_definition_name = "Storage Blob Data Reader"
      principal_id         = "user-guid-or-service-principal-id"
    },
    {
      role_definition_name = "Storage Blob Data Contributor"
      principal_id         = "user-guid-or-service-principal-id"
    }
  ]

  tags = {
    Environment = "dev"
    Project     = "MyProject"
  }
}
```

## 📋 Required Parameters

| Name | Type | Description |
|------|------|-------------|
| container_name | string | Name of the storage container |
| storage_account_name | string | Name of the storage account |
| container_access_type | string | Access type (private, blob, container) |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| role_assignments | list(object) | [] | List of RBAC role assignments |
| tags | map(string) | {} | Tags to apply to the container |

## 📤 Outputs

| Name | Description |
|------|-------------|
| container_name | Name of the created storage container |
| container_id | Resource ID of the container |

## 🔒 Security Features

- Configurable container access types
- RBAC role assignments
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Storage Documentation](https://docs.microsoft.com/en-us/azure/storage/common/storage-introduction)

## ⚠️ Notes

- Container names must be unique within the storage account
- Review container access types for your environment
- RBAC role assignments require appropriate permissions
- Consider using private endpoints for enhanced security
