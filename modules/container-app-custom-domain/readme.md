# Azure Container App Custom Domain Module

This module configures a custom domain for an Azure Container App, allowing for secure and branded access to your application. It follows Azure best practices for custom domain configuration.

## 🚀 Overview

The Container App Custom Domain module provides a standardized way to manage custom domains with:
- Custom domain configuration
- Lifecycle management
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing Container App

## 📦 Usage

```hcl
module "container_app_custom_domain" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/container-app-custom-domain"

  # Required parameters
  name             = "mycustomdomain.com"
  container_app_id = "my-container-app-id"

  tags = {
    Environment = "dev"
    Project     = "MyProject"
  }
}
```

## 📋 Required Parameters

| Name | Type | Description |
|------|------|-------------|
| name | string | Name of the custom domain |
| container_app_id | string | ID of the Container App |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| tags | map(string) | {} | Tags to apply to the custom domain |

## 📤 Outputs

| Name | Description |
|------|-------------|
| custom_domain_name | Name of the configured custom domain |
| custom_domain_id | Resource ID of the custom domain |

## 🔒 Security Features

- Custom domain configuration
- Lifecycle management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Container Apps Documentation](https://docs.microsoft.com/en-us/azure/container-apps/)

## ⚠️ Notes

- Custom domain names must be unique
- Ensure DNS records are properly configured
- Review lifecycle settings for your environment
