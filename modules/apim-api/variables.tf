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

variable "apim_instance" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
}

variable "api" {
  type = object({
    version      = number
    service_fqdn = string
    ingress_fqdn = string
  })
}

variable "keyvault_apimhostkey_secret_id" {
  type = string
}

variable "application_insights" {
  type = object({
    id                  = string
    instrumentation_key = string
  })
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
    policy_xml_content  = optional(string, null)

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

variable "subscription_required" {
  type    = bool
  default = true
}

variable "backend_url_override" {
  type    = string
  default = null
}