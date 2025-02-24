variable "dns_zone" {
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "ttl" {
  type = number
  default = 300
}

variable "name" {
  type = string
}

variable "value" {
  type = string
}
