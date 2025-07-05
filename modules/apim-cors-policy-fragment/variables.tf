variable "environment" {
  type        = string
  description = "The environment of the api management instance"
  default     = "dev"
}

variable "domain" {
  type        = string
  description = "The domain of the api management instance"
}

variable "name_discriminator" {
  type        = string
  description = "The name discriminator for the api management instance"
}

variable "apim_instance_id" {
  type        = string
  description = "The id of the api management instance"
}

variable "allowed_origins" {
  type    = list(string)
  default = []
}
