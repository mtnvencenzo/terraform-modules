variable "azureai_account_id" {
  type        = string
  description = "The ID of the Azure AI account"
}

variable "cosmosdb_account_id" {
  type        = string
  description = "The ID of the Cosmos DB account"
}

variable "cosmos_database_name" {
  type        = string
  description = "The name of the database for the Cosmos DB account"
}

variable "cosmos_container_name" {
  type        = string
  description = "The name of the container for the Cosmos DB account"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "cosmos_datasource_json" {
  type = string
}

variable "cosmos_standard_lucene_indexer_json" {
  type = string
}

variable "cosmos_standard_lucene_index_json" {
  type = string
}

variable "search_index_reader_role_assignment" {
  type    = list(string)
  default = []
}

