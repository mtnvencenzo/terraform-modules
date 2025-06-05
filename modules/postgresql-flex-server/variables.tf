
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

variable "sequence" {
  type    = string
  default = "001"
}

variable "storage" {
  type = number
}

variable "sku" {
  type = string
}

variable "delegated_subnet_id" {
  type = string
}

variable "private_dns_zone_id" {
  type = string
}

variable "administrator_login" {
  type = string
}

variable "administrator_password" {
  type = string
}

variable "postgres_version" {
  type = string
}

variable "create_mode" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}