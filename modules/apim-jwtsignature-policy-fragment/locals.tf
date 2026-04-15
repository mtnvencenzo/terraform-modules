locals {
  allowed_issuers = formatlist("<issuer>%s</issuer>", var.issuers)
}