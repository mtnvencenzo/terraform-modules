variable "storage_account_name" {
  type = string
}

variable "blob_containers" {
  type = list(object({
     name                   = string
     container_access_type  = optional(string, "private")
  }))
  default = []
}
