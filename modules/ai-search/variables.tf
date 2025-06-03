variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the search service"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name (e.g., dev, stg, prd)"
  type        = string
  default     = "dev"
}

variable "domain" {
  description = "Domain name for the search service"
  type        = string
}

variable "sequence" {
  description = "Sequence number for the search service"
  type        = string
  default     = "001"
}

variable "sub" {
  description = "Subscription identifier"
  type        = string
  default     = "vec"
}

variable "region" {
  description = "Region identifier"
  type        = string
  default     = "eus"
}

variable "sku" {
  description = "SKU for the search service (free, basic, standard, standard2, standard3)"
  type        = string
  default     = "free"
}

variable "replica_count" {
  description = "Number of replicas for the search service"
  type        = number
  default     = 1
}

variable "partition_count" {
  description = "Number of partitions for the search service"
  type        = number
  default     = 1
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the search service"
  type        = map(string)
  default     = {}
} 