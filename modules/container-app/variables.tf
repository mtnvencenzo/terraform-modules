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

variable "name_discriminator" {
  type = string
}

variable "sequence" {
  type    = string
  default = "001"
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "container_app_environment_id" {
  type = string
}

variable "revision_mode" {
  type    = string
  default = "Single"
}

variable "workload_profile_name" {
  type    = string
  default = "Consumption"
}

variable "max_inactive_revisions" {
  type    = number
  default = 5
}

variable "ingress_allow_insecure_connections" {
  type    = bool
  default = false
}

variable "ingress_external_enabled" {
  type    = bool
  default = true
}

variable "ingress_target_port" {
  type = string
}

variable "ingress_traffic_weights" {
  type = list(object({
    latest_revision = bool,
    percentage      = number
  }))
  default = [{
    latest_revision = true,
    percentage      = 100
  }]
}

variable "container_registry" {
  type = object({
    id           = string,
    login_server = string
  })
}

variable "key_vaults" {
  type = map(object({
    id   = string,
    name = string
  }))
  description = "Map of key vaults the container app needs access to. Keys are logical names referenced by secrets via key_vault_key."
}

variable "container" {
  type = object({
    name       = string
    image_name = string
    image_tag  = string
    cpu        = number
    memory     = string
  })
  default = {
    name       = null
    image_name = null
    image_tag  = null
    cpu        = 0.25
    memory     = "0.5Gi"
  }
}

variable "secrets" {
  type = list(object({
    name                  = string,
    key_vault_secret_name = string,
    key_vault_key         = optional(string, "default")
  }))
  default     = []
  description = "List of Key Vault secrets to mount. key_vault_key references a key in var.key_vaults (defaults to 'default')."
}

variable "min_replicas" {
  type    = number
  default = 1
}

variable "max_replicas" {
  type    = number
  default = 1
}

variable "startup_probe_relative_url" {
  type = string
}

variable "readiness_probe_relative_url" {
  type    = string
  default = null
}

variable "liveness_probe_relative_url" {
  type    = string
  default = null
}

variable "env_vars" {
  type = list(object({
    name  = string,
    value = string
  }))
  default = []
}

variable "env_secret_vars" {
  type = list(object({
    name        = string,
    secret_name = string
  }))
  default = []
}

variable "dapr" {
  type = object({
    app_id       = string
    app_protocol = optional(string)

    components = list(object({
      name           = string
      component_type = string
      version        = optional(string)
      scopes         = optional(list(string))
      metadata = list(object({
        name  = string
        value = optional(string)
      }))
    }))
  })
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}