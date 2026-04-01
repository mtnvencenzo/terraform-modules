
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

variable "storage_mb" {
  type    = number
  default = 32768
}

variable "storage_tier" {
  type    = string
  default = "P4"
}

variable "sku" {
  type = string
}

variable "delegated_subnet_id" {
  type    = string
  default = null
}

variable "private_dns_zone_id" {
  type    = string
  default = null
}

variable "administrator_login" {
  type = string
}

variable "administrator_password" {
  type = string
}

variable "create_mode" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "auto_grow_enabled" {
  type    = bool
  default = false
}

variable "version" {
  type    = number
  default = 18
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}
