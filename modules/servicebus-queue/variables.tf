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

variable "namespace_id" {
  type = string
}

variable "name_discriminator" {
  type = string
}

variable "lock_duration" {
  type    = string
  default = "PT1M"
}

variable "requires_duplicate_detection" {
  type    = bool
  default = true
}

variable "requires_session" {
  type    = bool
  default = false
}

variable "dead_lettering_on_message_expiration" {
  type    = bool
  default = true
}

variable "max_delivery_count" {
  type    = number
  default = 3
}

variable "duplicate_detection_history_time_window" {
  type    = string
  default = "PT10M"
}

variable "tags" {
  type    = map(string)
  default = {}
}