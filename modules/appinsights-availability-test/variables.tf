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

variable "name_discriminator" {
  type = string
}

variable "application_insights_id" {
  type = string
}

variable "geo_locations" {
  type = list(string)
  default = ["us-fl-mia-edge", "us-va-ash-azr", "us-ca-sjc-azr", "us-il-ch1-azr", "us-tx-sn1-azr"]
}

variable "timeout" {
  type    = number
  default = 60
}

variable "frequency" {
  type    = number
  default = 900
}

variable "description" {
  type = string
}

variable "retry_enabled" {
  type = bool
  default = true
}

variable "enabled" {
  type = bool
  default = true
}

variable "expected_status_code" {
  type = number
  default = 200
}

variable "ssl_check_enabled" {
  type = bool
  default = true
}

variable "ssl_cert_remaining_lifetime" {
  type = number
  default = 3
}

variable "follow_redirects_enabled" {
  type = bool
  default = false
}

variable "parse_dependent_requests_enabled" {
  type = bool
  default = false
}

variable "http_url" {
  type = string
}

variable "http_method" {
  type = string
  default = "GET"
}

variable "alert_resource_group_name" {
  type = string
}

variable "alert_description" {
  type = string
}

variable "alert_auto_mitigate" {
  type = bool
  default = true
}

variable "alert_enabled" {
  type = bool
  default = true
}

variable "alert_frequency" {
  type = string
  default = "PT30M"
}

variable "alert_window_size" {
  type = string
  default = "PT1H"
}

variable "alert_action_group_id" {
  type = string
}

variable "alert_failed_location_count" {
  type = number
  default = 2
}

variable "alert_severity" {
  type = number
  default = 0
}

variable "create_alert" {
  type = bool
  default = true
}

variable "headers" {
  type = list(object({name = string, value = string}))
}