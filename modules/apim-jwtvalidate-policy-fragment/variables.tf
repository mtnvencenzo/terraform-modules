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

variable "apim_instance_id" {
  type        = string
  description = "The id of the api management instance"
}

variable "oidc_config_url" {
  type        = string
  description = "The url of the oidc configuration.  e.g. (https://cezzis.b2clogin.com/cezzis.onmicrosoft.com/B2C_1_SignInSignUp_Policy/v2.0/.well-known/openid-configuration)"
}

variable "audiences" {
  type        = list(string)
  description = "The valid audiences of the api"
}

variable "issuers" {
  type        = list(string)
  description = "The valid issuers of the api.  E.g. (https://cezzis.b2clogin.com/fb512a9c-5b44-41ab-8042-6465769f16c9/v2.0/)"
}