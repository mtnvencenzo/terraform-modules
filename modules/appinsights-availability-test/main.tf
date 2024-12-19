resource "azurerm_application_insights_standard_web_test" "appinsights_standard_availability_test" {
    resource_group_name             = var.resource_group_name
    application_insights_id         = var.application_insights_id
    location                        = var.location

    name                            = "avt-${var.sub}-${var.region}-${var.environment}-${var.domain}${var.name_discriminator}-${var.sequence}"
    timeout                         = var.timeout
    frequency                       = var.frequency
    geo_locations                   = var.geo_locations
    description                     = var.description
    retry_enabled                   = var.retry_enabled
    enabled                         = var.enabled
    tags                            = {
                                        Environment = var.environment
                                        Application = var.domain
                                    }

    request {
        url                                 = var.http_url
        http_verb                           = var.http_method
        follow_redirects_enabled            = var.follow_redirects_enabled
        parse_dependent_requests_enabled    = var.parse_dependent_requests_enabled


        dynamic "header" {
            for_each = var.headers

            content {
              name = header.value["name"]
              value = header.value["value"]
            }
        }
    }

    validation_rules {
        expected_status_code            = var.expected_status_code
        ssl_check_enabled               = var.ssl_check_enabled
        ssl_cert_remaining_lifetime     = var.ssl_cert_remaining_lifetime
    }
}


resource "azurerm_monitor_metric_alert" "appinsights_standard_availability_test_alert" {
    name                        = "alert-${var.sub}-${var.environment}-${var.domain}${var.name_discriminator}-availability"
    count                       = var.create_alert ? 1 : 0
    resource_group_name         = var.alert_resource_group_name
    description                 = var.alert_description
    severity                    = var.alert_severity
    auto_mitigate               = var.alert_auto_mitigate
    enabled                     = var.alert_enabled
    frequency                   = var.alert_frequency
    scopes                      = [
        azurerm_application_insights_standard_web_test.appinsights_standard_availability_test.id,
        var.application_insights_id
    ]
    window_size                 = var.alert_window_size

    application_insights_web_test_location_availability_criteria {
        failed_location_count = var.alert_failed_location_count
        web_test_id = azurerm_application_insights_standard_web_test.appinsights_standard_availability_test.id
        component_id = var.application_insights_id
    }

    action {
        action_group_id = var.alert_action_group_id

        webhook_properties  = {
            Environment   = "${title(var.environment)}"
            Domain        = "${title(var.domain)}"
        }
    }
}
