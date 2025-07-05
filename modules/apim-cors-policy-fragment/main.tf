resource "azurerm_api_management_policy_fragment" "cors_policy_fragment" {
  api_management_id = var.apim_instance_id
  name              = "${var.environment}-${var.domain}-${var.name_discriminator}-cors-policy"
  format            = "xml"
  value             = <<XML
      <fragment>
        <cors allow-credentials="true">
          <allowed-origins>
            ${join("\n", local.apim_allowed_origins)}
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