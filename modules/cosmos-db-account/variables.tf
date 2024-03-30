
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

variable "location" {
  type    = string
  default = "East US"
}

variable "resource_group_name" {
  type = string
}

variable "consistency_level" {
  type = string
}

variable "geo_location" {
  type = string
}

variable "action_group_id" {
  type    = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "sequence" {
  type    = string
  default = "001"
}

variable "max_interval_in_seconds" {
  type    = number
  default = 5
}

variable "max_staleness_prefix" {
  type    = number
  default = 100
}

variable "enable_monitor_alerts" {
  type    = bool
  default = false
}