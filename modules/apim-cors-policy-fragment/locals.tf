locals {
  apim_allowed_origins = formatlist("<origin>%s</origin>", var.allowed_origins)
}