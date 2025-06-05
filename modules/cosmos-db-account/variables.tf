
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

variable "consistency_level" {
  type = string
}

variable "geo_location" {
  type = string
}

variable "action_group_id" {
  type    = string
  default = ""
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

variable "tags" {
  type    = map(string)
  default = {}
}

variable "ip_range_filter" {
  type    = list(string)
  default = []
}

variable "account_reader_role_assignments" {
  type = list(object({
    name         = string
    principal_id = string
  }))
  default = []
}

variable "account_contributor_role_assignments" {
  type = list(object({
    name         = string
    principal_id = string
  }))
  default = []
}