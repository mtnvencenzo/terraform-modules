variable "dns_zone" {
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "ttl" {
  type = number
  default = 300
}

variable "custom_domain_verification_id" {
  type = string
}

variable "sub_domain" {
  type = string
}

variable "record_fqdn" {
  type = string
}