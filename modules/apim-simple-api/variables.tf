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
    principal_id        = string
  })
}

variable "api" {
  type = object({
    version      = number
    service_fqdn = string
    ingress_fqdn = string
  })
}


variable "application_insights" {
  type = object({
    id                  = string
    instrumentation_key = string
  })
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