locals {
  tags = {
    Environment = var.environment
    Application = var.domain
  }

  apim_allowed_origins = formatlist("<origin>%s</origin>", var.allowed_origins)

  anonomous_operation_policy = <<XML
      <policies>
        <inbound>
          <set-backend-service backend-id="${var.environment}-${var.domain}-${var.name_discriminator}-backend" />
          <include-fragment fragment-id="${var.environment}-${var.domain}-${var.name_discriminator}-cors-policy" />
        </inbound>
        <backend><base /></backend>
        <outbound><base /></outbound>
        <on-error><base /></on-error>
      </policies>
    XML

  b2c_auth_operation_policy = <<XML
      <policies>
        <inbound>
          <include-fragment fragment-id="${var.environment}-${var.domain}-${var.name_discriminator}-b2c-policy" />
          <set-backend-service backend-id="${var.environment}-${var.domain}-${var.name_discriminator}-backend" />
          <include-fragment fragment-id="${var.environment}-${var.domain}-${var.name_discriminator}-cors-policy" />
        </inbound>
        <backend><base /></backend>
        <outbound><base /></outbound>
        <on-error><base /></on-error>
      </policies>
    XML
}