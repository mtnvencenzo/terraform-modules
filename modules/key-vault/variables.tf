variable "sub" {
  type    = string
  default = "vec"
}

variable "region" {
  type    = string
  default = "eus"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "domain" {
  type = string
}

variable "shortdomain" {
  type = string
}

variable "sequence" {
  type        = string
  description = "The sequence number of the resource typically starting with 001"
  default     = "001"
}

variable "tenant_id" {
  type = string
}

variable "pipeline_object_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "virtual_network_subnet_ids" {
  type = list(string)
}

variable "secrets" {
  type = list(object({
    name  = string,
    value = string,
    tags  = optional(map(string), {})
  }))
  default = []
}

variable "secrets_values_ignored" {
  type = list(object({
    name  = string,
    value = string,
    tags  = optional(map(string), {})
  }))
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}