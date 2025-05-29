# Azure Key Vault Module

This module creates and configures an Azure Key Vault with access policies and secrets management. It follows Azure best practices for security and secret management.

## 🚀 Overview

The Key Vault module provides a standardized way to create and manage Azure Key Vaults with:
- Secure secret storage
- Access policy management
- Network access controls
- Soft delete and purge protection
- Secret versioning
- Pipeline integration

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. Required permissions to create Key Vaults
4. Tenant ID and pipeline object ID available

## 📦 Usage

```hcl
module "key_vault" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/key-vault"

  # Required parameters
  resource_group_name      = "my-resource-group"
  resource_group_location  = "eastus"
  tenant_id               = "your-tenant-id"
  pipeline_object_id      = "your-pipeline-object-id"
  domain                  = "myapp"
  shortdomain            = "app"
  sequence               = "001"
  
  # Optional parameters
  environment            = "dev"
  virtual_network_subnet_ids = ["/subscriptions/.../subnets/subnet1"]
  
  secrets = [
    {
      name  = "secret1"
      value = "value1"
    },
    {
      name  = "secret2"
      value = "value2"
    }
  ]

  secrets_values_ignored = [
    {
      name  = "dynamic-secret"
      value = "initial-value"
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
| resource_group_name | string | Name of the resource group |
| resource_group_location | string | Azure region for the Key Vault |
| tenant_id | string | Azure AD tenant ID |
| pipeline_object_id | string | Object ID for pipeline access |
| domain | string | Domain name for the Key Vault |
| shortdomain | string | Short domain name for the Key Vault |
| sequence | string | Sequence number for the Key Vault |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| environment | string | "dev" | Environment name (dev, staging, prod) |
| virtual_network_subnet_ids | list(string) | [] | List of subnet IDs for network rules |
| secrets | list(object) | [] | List of secrets to create |
| secrets_values_ignored | list(object) | [] | List of secrets whose values should be ignored in future updates |
| tags | map(string) | {} | Tags to apply to the Key Vault |

## 📤 Outputs

| Name | Description |
|------|-------------|
| key_vault_name | Name of the created Key Vault |
| key_vault_id | Resource ID of the Key Vault |
| key_vault_uri | URI of the Key Vault |

## 🔒 Security Features

- Soft delete enabled (7 days retention)
- Purge protection enabled
- Network access controls
- Access policies for pipeline integration
- Secret versioning
- Azure Services bypass for trusted services

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Key Vault Documentation](https://docs.microsoft.com/en-us/azure/key-vault/general/overview)

## ⚠️ Notes

- Key Vault names must be globally unique
- Soft delete cannot be disabled once enabled
- Consider using private endpoints for enhanced security
- Review access policies carefully for production environments
- Use secrets_values_ignored for secrets that are managed outside of Terraform
- The module prevents accidental destruction of the Key Vault
