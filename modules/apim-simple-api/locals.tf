locals {
  tags = {
    Environment = var.environment
    Application = var.domain
  }

  anonomous_operation_policy = <<XML
      <policies>
        <inbound>
          <set-backend-service backend-id="${var.environment}-${var.domain}-${var.name_discriminator}-backend" />
        </inbound>
        <backend><base /></backend>
        <outbound><base /></outbound>
        <on-error><base /></on-error>
      </policies>
    XML
}