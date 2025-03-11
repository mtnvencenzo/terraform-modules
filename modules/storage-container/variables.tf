variable "storage_account_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_access_type" {
  type    = string
  default = "private"
}

variable "role_assignments" {
  type = list(object({
    role_definition_name  = string
    principal_id          = string
  }))
  default = []
}