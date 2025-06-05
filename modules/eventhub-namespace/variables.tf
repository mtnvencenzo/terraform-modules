
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

variable "location" {
  type    = string
  default = "East US"
}

variable "resource_group_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "sequence" {
  type    = string
  default = "001"
}

variable "tags" {
  type    = map(string)
  default = {}
}