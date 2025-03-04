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

variable "name_discriminator" {
  type    = string
}

variable "short_sequence" {
  type    = string
  description = "The sequence number of the resource typically starting with 001"
  default = "1"
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "allowed_origins" {
  type = list(string)
}

variable "blob_containers" {
  type = list(object({
     name = string
  }))
  default = []
}
