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
  default = "001"
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "East US"
}

variable "subscription_id" {
  type    = string
}

variable "correlation_filter_label" {
  type    = string
}
