variable "dns_zone" {
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "ttl" {
  type    = number
  default = 300
}

variable "spf_include_domain" {
  type = string
}

variable "dkim_record" {
  type = object({
    name  = string
    value = string
  })
}

variable "record_exchanges" {
  type = list(object({
    preference = number
    exchange   = string
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
