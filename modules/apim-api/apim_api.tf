resource "azurerm_api_management_api_version_set" "apim_api_version_set" {
  name                = "${var.environment}-${var.domain}-${var.name_discriminator}"
  resource_group_name = var.apim_instance.resource_group_name
  api_management_name = var.apim_instance.name
  display_name        = "${title(var.environment)} ${title(var.domain)} ${title(var.name_discriminator)}"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_api_version" {
  name                  = "${var.environment}-${var.domain}-${var.name_discriminator}-v${var.api.version}"
  resource_group_name   = var.apim_instance.resource_group_name
  api_management_name   = var.apim_instance.name
  path                  = "${var.environment}/${var.domain}/${var.name_discriminator}"
  revision              = "v${var.api.version}"
  display_name          = "${title(var.environment)} ${title(var.domain)} ${title(var.name_discriminator)}"
  protocols             = ["https"]
  service_url           = var.service_url_override != null ? var.service_url_override : "https://${var.api.service_fqdn}/${var.name_discriminator}/v${var.api.version}"
  api_type              = "http"
  subscription_required = var.subscription_required

  version             = "v${var.api.version}"
  version_set_id      = azurerm_api_management_api_version_set.apim_api_version_set.id
  version_description = "${title(var.environment)} ${title(var.domain)} ${title(var.name_discriminator)} v${var.api.version}"

  subscription_key_parameter_names {
    header = "X-Key"
    query  = "x-key"
  }

  depends_on = [
    azurerm_api_management_api_version_set.apim_api_version_set
  ]
}

resource "azurerm_api_management_logger" "apim_appinsights_logger" {
  count               = var.application_insights != null ? 1 : 0
  name                = "${var.environment}-${var.domain}-${var.name_discriminator}-appinsights-logger"
  description         = "${title(var.environment)} ${var.domain} ${var.name_discriminator} app insights logger for the api management instance"
  resource_group_name = var.apim_instance.resource_group_name
  api_management_name = var.apim_instance.name
  resource_id         = var.application_insights.id

  application_insights {
    instrumentation_key = var.application_insights.instrumentation_key
  }
}

resource "azurerm_api_management_api_diagnostic" "apim_api_diagnostic" {
  count                    = var.application_insights != null ? 1 : 0
  identifier               = "applicationinsights"
  api_name                 = azurerm_api_management_api.apim_api_version.name
  resource_group_name      = var.apim_instance.resource_group_name
  api_management_name      = var.apim_instance.name
  api_management_logger_id = azurerm_api_management_logger.apim_appinsights_logger[0].id

  sampling_percentage       = 5.0
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "information"
  http_correlation_protocol = "W3C"
  operation_name_format     = "Name"

  frontend_request {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  frontend_response {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }

  depends_on = [
    azurerm_api_management_logger.apim_appinsights_logger
  ]
}

