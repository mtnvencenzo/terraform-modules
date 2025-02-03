

resource "azurerm_api_management_api_version_set" "apim_api_version_set" {
  name                = "${var.environment}-${var.domain}-${var.name_discriminator}"
  resource_group_name = var.apim_instance.resource_group_name
  api_management_name = var.apim_instance.name
  display_name        = "${title(var.environment)} ${title(var.domain)} ${title(var.name_discriminator)}"
  versioning_scheme   = "Segment"
}


resource "azurerm_api_management_api" "apim_api_version" {
    name                = "${var.environment}-${var.domain}-${var.name_discriminator}-v${var.api.version}"
    resource_group_name = var.apim_instance.resource_group_name
    api_management_name = var.apim_instance.name
    path                = "${var.environment}/${var.domain}/${var.name_discriminator}"
    revision            = "v${var.api.version}"
    display_name        = "${title(var.environment)} ${title(var.domain)} ${title(var.name_discriminator)}"
    protocols           = ["https"]
    service_url         = "https://${var.api.service_fqdn}/${var.name_discriminator}/v${var.api.version}"
    api_type            = "http"

    version = "v${var.api.version}"
    version_set_id = azurerm_api_management_api_version_set.apim_api_version_set.id
    version_description = "${title(var.environment)} ${title(var.domain)} ${title(var.name_discriminator)} v${var.api.version}"

    subscription_key_parameter_names {
      header  = "X-Key"
      query   = "x-key"
    }

    depends_on = [
      azurerm_api_management_api_version_set.apim_api_version_set
    ]
}


resource "azurerm_api_management_policy_fragment" "apim_api_cors_policy_fragment" {
  api_management_id = data.azurerm_api_management.apim_shared.id
  name              = "${var.environment}-${var.domain}-${var.name_discriminator}-cors-policy"
  format            = "xml"
  value             = <<XML
      <fragment>
        <cors allow-credentials="true">
          <allowed-origins>
            ${ join("\n", locals.apim_allowed_origins) }
          </allowed-origins>
          <allowed-methods>
            <method>*</method>
          </allowed-methods>
          <allowed-headers>
            <header>*</header>
          </allowed-headers>
        </cors>
      </fragment>
    XML
}

resource "azurerm_api_management_policy_fragment" "apim_api_b2c_policy_fragment" {
  api_management_id = data.azurerm_api_management.apim_shared.id
  name              = "${var.environment}-${var.domain}-${var.name_discriminator}-b2c-policy"
  format            = "xml"
  value             = <<XML
      <fragment>
          <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized. Access token is missing or invalid.">
              <openid-config url="https://${var.b2c_auth.tenant_name}.b2clogin.com/${var.b2c_auth.tenant_name}.onmicrosoft.com/${var.b2c_auth.signin_policy}/v2.0/.well-known/openid-configuration" />
              <audiences>
                  <audience>${var.api.audience}</audience>
              </audiences>
              <issuers>
                  <issuer>https://${var.b2c_auth.tenant_name}.b2clogin.com/${var.b2c_auth.tenant_id}/v2.0/</issuer>
              </issuers>
          </validate-jwt>
      </fragment>
    XML
}

resource "azurerm_api_management_api_diagnostic" "apim_api_diagnostic" {
  count                     = var.application_insights != null ? 1 : 0
  identifier                = "applicationinsights"
  api_name                  = azurerm_api_management_api.apim_api_version.name
  resource_group_name       = var.apim_instance.resource_group_name
  api_management_name       = var.apim_instance.name
  api_management_logger_id  = azurerm_api_management_logger.apim_appinsights_logger.id

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

