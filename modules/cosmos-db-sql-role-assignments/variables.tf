variable "resource_group_name" {
  type = string
}

variable "cosmosdb_account_name" {
  type = string
}

variable "database_id" {
  type = string
}

variable "database_role_assignments" {
  type = list(object({
    name               = string
    role_definition_id = string
    principal_id       = string
  }))
  default = []
}