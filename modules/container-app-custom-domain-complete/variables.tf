variable "dns_zone_name" {
  type        = string
  description = "The name of the dns zone to create the txt and cname records in"
}

variable "sub_domain" {
  type        = string
  description = "The sub domain to create the txt and cname records in"
}

variable "dns_resource_group_name" {
  type = string
}

variable "custom_domain_verification_id" {
  type        = string
  description = "The verification id for the custom domain"
}

variable "container_app_ingress_fqdn" {
  type        = string
  description = "The fqdn of the container app ingress"
}

variable "container_app_id" {
  type        = string
  description = "The id of the container app"
}

variable "container_app_resource_group_location" {
  type        = string
  description = "The location of the container app resource group"
}

variable "container_app_environment_id" {
  type        = string
  description = "The id of the container app environment"
}

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

variable "name_discriminator" {
  type = string
}

variable "sequence" {
  type    = string
  default = "001"
}

variable "resource_group_location" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}