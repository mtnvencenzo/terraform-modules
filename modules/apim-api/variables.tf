variable "environment" {
  type    = string
  default = "dev"
}

variable "domain" {
  type = string
}

variable "name_discriminator" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "apim_instance" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
    principal_id        = string
  })
}

variable "api" {
  type = object({
    version      = number
    service_fqdn = string
    ingress_fqdn = string
    audience     = string
  })
}

variable "keyvault_apimhostkey_secret_id" {
  type = string
}

variable "key_vault" {
  type = object({
    id   = string,
    name = string
  })
}

variable "application_insights" {
  type = object({
    id                  = string
    instrumentation_key = string
  })
}

variable "b2c_auth" {
  type = object({
    tenant_name   = string
    signin_policy = string
    tenant_id     = string
  })
  default = {
    tenant_name   = ""
    signin_policy = ""
    tenant_id     = ""
  }
}

variable "allowed_origins" {
  type    = list(string)
  default = []
}

variable "subscriptions" {
  type = list(object({
    name          = string
    primary_key   = string
    secondary_key = string
  }))
  default = []
}

variable "operations" {
  type = list(object({
    display_name        = string
    method              = string
    url_template        = string
    description         = string
    success_status_code = number
    security_type       = string

    template_parameters = optional(list(object({
      name = string
      type = string
    })), [])
  }))
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}