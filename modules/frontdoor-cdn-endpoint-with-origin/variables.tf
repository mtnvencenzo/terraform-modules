variable "sub" {
  type    = string
  default = "vec"
}

variable "region" {
  type	= string
  default = "eus"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "domain" {
  type = string
}

variable "sequence" {
  type    = string
  description = "The sequence number of the resource typically starting with 001"
  default = "001"
}

variable "cdn_frontdoor_profile_id" {
  type = string
}

variable "origin_host_name" {
  type = string
}

variable "custom_domain" {
  type = object({
    dns_zone_name             = string
    dns_zone_resource_group   = string
    sub_domain                = string
    host_name                 = string
  })
  default = null
}

variable "allowed_origins" {
  type = list(string)
  default = []
}

variable "caching_rule" {
  type = object({
    cache_duration = optional(string)
    ignore_query_strings  = optional(bool)
    compression_enabled = optional(bool)
  })
}