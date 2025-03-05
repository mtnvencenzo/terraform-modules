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

variable "cdn_ruleset_name" {
  type = string
}

variable "cache_duration" {
  type = string
  default = "60.00:00:00"
}