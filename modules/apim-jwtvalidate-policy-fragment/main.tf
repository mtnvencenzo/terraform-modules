resource "azurerm_api_management_policy_fragment" "jwtvalidate_policy_fragment" {
  api_management_id = var.apim_instance_id
  name              = "${var.environment}-${var.domain}-${var.name_discriminator}-jwtvalidate-policy"
  format            = "xml"
  value             = <<XML
      <fragment>
          <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized. Access token is missing or invalid.">
              <openid-config url="${var.oidc_config_url}" />
              <audiences>
                ${join("\n", local.apim_allowed_audiences)}
              </audiences>
              <issuers>
                ${join("\n", local.apim_allowed_issuers)}
              </issuers>
          </validate-jwt>
      </fragment>
    XML
}