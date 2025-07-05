locals {
  tags = {
    Environment = var.environment
    Application = var.domain
  }

  apim_allowed_audiences = formatlist("<audience>%s</audience>", var.audiences)

  apim_allowed_issuers = formatlist("<issuer>%s</issuer>", var.issuers)
}