
resource "azurerm_api_management_named_value" "jwt_signature_signing_secret" {
  name                = "${var.environment}-${var.domain}-${var.name_discriminator}-jwtsignaturekey"
  resource_group_name = var.apim_instance.resource_group_name
  api_management_name = var.apim_instance.name
  display_name        = "${var.environment}-${var.domain}-${var.name_discriminator}-jwtsignaturekey"
  secret              = true

  value_from_key_vault {
    secret_id = var.keyvault_signaturekey_secret_id
  }
}


resource "azurerm_api_management_policy_fragment" "jwtsignature_policy_fragment" {
  api_management_id = var.apim_instance_id
  name              = "${var.environment}-${var.domain}-${var.name_discriminator}-jwtsignature-policy"
  format            = "xml"
  value             = <<XML
      <fragment>
        <validate-jwt header-name="${var.header_name}"
                      failed-validation-httpcode="401"
                      failed-validation-error-message="Access denied"
                      clock-skew="60"
                      require-expiration-time="true"
                      require-signed-tokens="true">
          <issuer-signing-keys>
            <key>{{${azurerm_api_management_named_value.jwt_signature_signing_secret.name}}}</key>
          </issuer-signing-keys>
            <issuers>
              ${join("\n", local.allowed_issuers)}
            </issuers>
        </validate-jwt>
      </fragment>
    XML
}