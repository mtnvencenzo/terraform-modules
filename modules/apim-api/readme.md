# Azure API Management API Module

This module creates and configures an Azure API Management API with versioning, authentication, CORS, and diagnostic settings. It follows Azure best practices for API management and security.

## 🚀 Overview

The API Management API module provides a standardized way to create and manage APIs with:
- Version management
- B2C authentication integration
- CORS configuration
- Application Insights integration
- Custom subscription key names
- Diagnostic logging
- Policy fragments

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. API Management instance created
4. Azure B2C tenant configured (if using B2C authentication)
5. Application Insights instance (optional, for diagnostics)

## 📦 Usage

```hcl
module "apim_api" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/apim-api"

  # Required parameters
  apim_instance = {
    resource_group_name = "my-resource-group"
    name               = "my-apim"
    id                 = "your-apim-id"
  }
  
  environment        = "dev"
  domain            = "myapp"
  name_discriminator = "api"
  
  api = {
    version     = "1"
    service_fqdn = "api.myapp.com"
  }

  # Application Insights (optional)
  application_insights = {
    id   = "your-appinsights-id"
    name = "your-appinsights-name"
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
| apim_instance | object | API Management instance configuration |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the API |
| name_discriminator | string | Unique identifier for the API |
| api | object | API configuration including version and service URL |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| application_insights | object | null | Application Insights configuration |
| allowed_origins | list(string) | [] | List of allowed CORS origins |
| tags | map(string) | {} | Tags to apply to the API |

## 📤 Outputs

| Name | Description |
|------|-------------|
| api_name | Name of the created API |
| api_id | Resource ID of the API |
| version_set_id | ID of the API version set |
| policy_fragment_ids | IDs of the created policy fragments |

## 🔒 Security Features

- HTTPS-only protocols
- Custom subscription key names
- Diagnostic logging

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure API Management Documentation](https://docs.microsoft.com/en-us/azure/api-management/api-management-key-concepts)

## ⚠️ Notes

- API names must be unique within the API Management instance
- Version numbers should follow semantic versioning
- CORS origins should be carefully configured for security
- B2C policies must be created before using this module
- Consider using Application Insights for monitoring and diagnostics
- Review and adjust diagnostic settings based on your needs
- Policy fragments can be reused across multiple APIs
