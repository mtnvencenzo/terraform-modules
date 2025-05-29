# Azure Application Insights Availability Test Module

This module creates and configures an Azure Application Insights Availability Test with web test settings and alert configurations. It follows Azure best practices for monitoring and security.

## 🚀 Overview

The Application Insights Availability Test module provides a standardized way to deploy and manage availability tests with:
- Web test configuration
- Alert settings
- Validation rules
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing Application Insights instance

## 📦 Usage

```hcl
module "appinsights_availability_test" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/appinsights-availability-test"

  # Required parameters
  resource_group_name     = "my-resource-group"
  application_insights_id = "my-appinsights-id"
  location               = "eastus"
  sub                    = "myapp"
  region                 = "eastus"
  environment            = "dev"
  domain                 = "myapp"
  name_discriminator     = "test"
  sequence               = "001"
  http_url               = "https://myapp.com/health"
  http_method            = "GET"

  # Optional parameters
  timeout                         = 30
  frequency                       = 300
  geo_locations                   = ["East US", "West Europe"]
  description                     = "Health check for my application"
  retry_enabled                   = true
  enabled                         = true
  follow_redirects_enabled        = true
  parse_dependent_requests_enabled = true
  expected_status_code            = 200
  ssl_check_enabled               = true
  ssl_cert_remaining_lifetime     = 30

  # Alert configuration
  create_alert              = true
  alert_resource_group_name = "my-alert-rg"
  alert_description         = "Alert when availability test fails"
  alert_severity           = 1
  alert_auto_mitigate      = true
  alert_enabled            = true
  alert_frequency          = "PT5M"
  alert_window_size        = "PT15M"
  alert_failed_location_count = 1
  alert_action_group_id    = "my-action-group-id"

  headers = [
    {
      name  = "Authorization"
      value = "Bearer ${var.api_token}"
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
| application_insights_id | string | ID of the Application Insights instance |
| location | string | Azure region for the test |
| sub | string | Subscription identifier |
| region | string | Azure region for the test |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the test |
| name_discriminator | string | Unique identifier for the test |
| sequence | string | Sequence number for the test |
| http_url | string | URL to test |
| http_method | string | HTTP method to use for the test |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| timeout | number | 30 | Test timeout in seconds |
| frequency | number | 300 | Test frequency in seconds |
| geo_locations | list(string) | [] | List of test locations |
| description | string | null | Test description |
| retry_enabled | bool | true | Enable test retry |
| enabled | bool | true | Enable the test |
| follow_redirects_enabled | bool | true | Enable following redirects |
| parse_dependent_requests_enabled | bool | true | Enable parsing dependent requests |
| expected_status_code | number | 200 | Expected HTTP status code |
| ssl_check_enabled | bool | true | Enable SSL certificate check |
| ssl_cert_remaining_lifetime | number | 30 | Minimum SSL certificate lifetime in days |
| create_alert | bool | false | Create alert for test failures |
| alert_resource_group_name | string | null | Resource group for the alert |
| alert_description | string | null | Alert description |
| alert_severity | number | 1 | Alert severity (0-4) |
| alert_auto_mitigate | bool | true | Enable alert auto-mitigation |
| alert_enabled | bool | true | Enable the alert |
| alert_frequency | string | "PT5M" | Alert evaluation frequency |
| alert_window_size | string | "PT15M" | Alert evaluation window |
| alert_failed_location_count | number | 1 | Number of failed locations to trigger alert |
| alert_action_group_id | string | null | Action group ID for alert notifications |
| headers | list(object) | [] | List of HTTP headers for the test |
| tags | map(string) | {} | Tags to apply to the test |

## 📤 Outputs

| Name | Description |
|------|-------------|
| test_name | Name of the created availability test |
| test_id | Resource ID of the test |

## 🔒 Security Features

- SSL certificate validation
- HTTP header support
- Alert configuration
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Application Insights Documentation](https://docs.microsoft.com/en-us/azure/azure-monitor/app/availability-overview)

## ⚠️ Notes

- Test names must be unique within the Application Insights instance
- Review alert settings for your environment
- Ensure SSL certificate checks are properly configured
- Consider using private endpoints for enhanced security
- Monitor test results and adjust thresholds as needed
