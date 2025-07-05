locals {
  tags = {
    Environment = var.environment
    Application = var.domain
  }

  apim_allowed_origins = formatlist("<origin>%s</origin>", var.allowed_origins)
}