variable "resource_group_name" {
  type = string
}

variable "cosmosdb_account_name" {
  type = string
}

variable "database_name" {
  type = string
}

variable "containers" {
  type = list(object({
    name                  = string
    partition_key_paths   = list(string)
    partition_key_version = optional(number)
    throughput            = optional(number)
    indexing_mode         = optional(string)
    indexing_path         = optional(string)
    unique_key_paths      = list(string)
  }))
  default = []
}