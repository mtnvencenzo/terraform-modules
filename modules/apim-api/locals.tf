locals {
  tags = {
    Environment = var.environment
    Application = var.domain
  }

  apim_allowed_origins = formatlist("<origin>%s</origin>", var.allowed_origins)

  anonomous_operation_policy = <<XML
      <policies>
        <inbound>
          <set-backend-service backend-id="${azurerm_api_management_backend.apim_api_backend.name}" />
          <include-fragment fragment-id="${ azurerm_api_management_policy_fragment.apim_api_cors_policy_fragment.name }" />
        </inbound>
        <backend><base /></backend>
        <outbound><base /></outbound>
        <on-error><base /></on-error>
      </policies>
    XML

  b2c_auth_operation_policy = <<XML
      <policies>
        <inbound>
          <include-fragment fragment-id="${ azurerm_api_management_policy_fragment.apim_api_b2c_policy_fragment.name }" />
          <set-backend-service backend-id="${azurerm_api_management_backend.apim_api_backend.name}" />
          <include-fragment fragment-id="${ azurerm_api_management_policy_fragment.apim_api_cors_policy_fragment.name }" />
        </inbound>
        <backend><base /></backend>
        <outbound><base /></outbound>
        <on-error><base /></on-error>
      </policies>
    XML
}