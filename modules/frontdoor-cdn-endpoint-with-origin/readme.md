# Azure Front Door CDN Endpoint with Origin Module

This module creates and configures an Azure Front Door CDN Endpoint with origin group and route settings. It follows Azure best practices for CDN deployment and security.

## 🚀 Overview

The Front Door CDN Endpoint with Origin module provides a standardized way to deploy and manage CDN endpoints with:
- Endpoint configuration
- Origin group settings
- Route configuration
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing Front Door CDN Profile

## 📦 Usage

```hcl
module "frontdoor_cdn_endpoint_with_origin" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/frontdoor-cdn-endpoint-with-origin"

  # Required parameters
  cdn_frontdoor_profile_id = "my-profile-id"
  sub                      = "myapp"
  region                   = "eastus"
  environment              = "dev"
  domain                   = "myapp"
  sequence                 = "001"
  origin_host_name         = "myapp.azurewebsites.net"

  # Optional parameters
  allowed_origins = ["https://myapp.com"]
  custom_domain   = {
    name = "myapp.com"
  }
  caching_rule = {
    name = "my-caching-rule"
  }

  tags = {
    Environment = "dev"
    Project     = "MyProject"
  }
}
```

## 📋 Required Parameters

| Name | Type | Description |
|------|------|-------------|
| cdn_frontdoor_profile_id | string | ID of the Front Door CDN Profile |
| sub | string | Subscription identifier |
| region | string | Azure region for the endpoint |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the endpoint |
| sequence | string | Sequence number for the endpoint |
| origin_host_name | string | Host name for the origin |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| allowed_origins | list(string) | [] | List of allowed origins for CORS |
| custom_domain | object | null | Custom domain configuration |
| caching_rule | object | null | Caching rule configuration |
| tags | map(string) | {} | Tags to apply to the endpoint |

## 📤 Outputs

| Name | Description |
|------|-------------|
| endpoint_name | Name of the created Front Door CDN Endpoint |
| origin_group_name | Name of the created Origin Group |
| route_name | Name of the created Route |

## 🔒 Security Features

- Endpoint configuration
- Origin group settings
- Route configuration
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Front Door Documentation](https://docs.microsoft.com/en-us/azure/frontdoor/)

## ⚠️ Notes

- Endpoint names must be unique within the Front Door CDN Profile
- Review origin group settings for your environment
- Ensure route configurations are properly set up
- Consider using private endpoints for enhanced security
