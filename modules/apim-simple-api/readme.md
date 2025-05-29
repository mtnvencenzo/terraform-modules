# Azure API Management Simple API Module

This module creates and configures an Azure API Management API with versioning, operations, and diagnostics settings. It follows Azure best practices for API management and security.

## 🚀 Overview

The APIM Simple API module provides a standardized way to deploy and manage APIs with:
- API versioning
- Operation configuration
- Diagnostics settings
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing API Management instance

## 📦 Usage

```hcl
module "apim_simple_api" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/apim-simple-api"

  # Required parameters
  apim_instance = {
    name                = "my-apim"
    resource_group_name = "my-resource-group"
  }
  environment       = "dev"
  domain           = "myapp"
  name_discriminator = "api"
  api = {
    version     = "1"
    service_fqdn = "api.myapp.com"
  }

  # Optional parameters
  operations = [
    {
      method             = "get"
      display_name       = "Get Resource"
      url_template       = "/resource/{id}"
      description        = "Retrieves a resource by ID"
      success_status_code = 200
      template_parameters = [
        {
          name = "id"
          type = "string"
        }
      ]
    }
  ]

  application_insights = {
    name                = "my-appinsights"
    resource_group_name = "my-resource-group"
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
| api | object | API configuration including version and service FQDN |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| operations | list(object) | [] | List of API operations |
| application_insights | object | null | Application Insights configuration |
| tags | map(string) | {} | Tags to apply to the API |

## 📤 Outputs

| Name | Description |
|------|-------------|
| api_name | Name of the created API |
| api_id | Resource ID of the API |
| version_set_id | ID of the API version set |

## 🔒 Security Features

- HTTPS-only protocols
- Subscription key configuration
- Diagnostics logging
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure API Management Documentation](https://docs.microsoft.com/en-us/azure/api-management/)

## ⚠️ Notes

- API names must be unique within the API Management instance
- Review operation configurations for your environment
- Ensure diagnostics settings are properly configured
- Consider using private endpoints for enhanced security
- Monitor API usage and adjust settings as needed
