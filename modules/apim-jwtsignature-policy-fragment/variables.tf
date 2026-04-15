variable "environment" {
  type        = string
  description = "The environment of the api management instance"
  default     = "dev"
}

variable "domain" {
  type        = string
  description = "The domain of the api management instance"
}

variable "name_discriminator" {
  type        = string
  description = "The name discriminator for the api management instance"
}

variable "apim_instance" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
}

variable "issuers" {
  type        = list(string)
  description = "The valid issuers of the api.  E.g. (https://cezzis.b2clogin.com/fb512a9c-5b44-41ab-8042-6465769f16c9/v2.0/)"
}

variable "header_name" {
  type        = string
  description = "The name of the header from which to extract the JWT."
}

variable "keyvault_signaturekey_secret_id" {
  type        = string
  description = "The full secret id of the Key Vault secret that contains the JWT signing key. E.g. https://mykeyvault.vault.azure.net/secrets/mysecret/1234567890abcdef"
}