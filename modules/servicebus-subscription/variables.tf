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

variable "topic_id" {
  type    = string
}

variable "name_discriminator" {
  type    = string
}

variable "forward_to" {
  type    = string
}

variable "max_delivery_count" {
  type    = number
  default = 1
}