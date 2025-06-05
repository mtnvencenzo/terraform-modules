# Azure AI Search Cosmos Index Simple Module

This module creates and configures an Azure AI Search index with a Cosmos DB data source. It provides a simplified way to set up search functionality for your Cosmos DB data.

## 🚀 Overview

The AI Search Cosmos Index Simple module provides a standardized way to deploy and manage search indexes with:
- Cosmos DB data source integration
- Index schema configuration
- Search service connection
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing Cosmos DB account
4. An existing Azure AI Search service

## 📦 Usage

```hcl
module "ai_search_cosmos_index" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/ai-search-cosmos-index-simple"

  # Required parameters
  cosmosdb_account_id    = "/subscriptions/.../resourceGroups/.../providers/Microsoft.DocumentDB/databaseAccounts/..."
  cosmos_database_name   = "mydatabase"
  cosmos_container_name  = "mycollection"
  
  # JSON configurations
  cosmos_datasource_json = jsonencode({
    name = "cosmos-datasource"
    type = "cosmosdb"
    # ... other datasource configuration
  })
  
  cosmos_standard_lucene_index_json = jsonencode({
    name = "cosmos-index"
    fields = [
      # ... index field definitions
    ]
  })
  
  cosmos_standard_lucene_indexer_json = jsonencode({
    name = "cosmos-indexer"
    # ... indexer configuration
  })

  tags = {
    Environment = "dev"
    Project     = "MyProject"
  }
}
```

## 📋 Required Parameters

| Name | Type | Description |
|------|------|-------------|
| cosmosdb_account_id | string | The ID of the Cosmos DB account |
| cosmos_database_name | string | The name of the database for the Cosmos DB account |
| cosmos_container_name | string | The name of the container for the Cosmos DB account |
| cosmos_datasource_json | string | JSON configuration for the Cosmos DB data source |
| cosmos_standard_lucene_index_json | string | JSON configuration for the search index |
| cosmos_standard_lucene_indexer_json | string | JSON configuration for the indexer |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| tags | map(string) | {} | Tags to apply to the resources |

## 📤 Outputs

| Name | Description |
|------|-------------|
| datasource_name | Name of the created data source |
| index_name | Name of the created search index |
| indexer_name | Name of the created indexer |

## 🔒 Security Features

- Secure connection to Cosmos DB
- Managed identity support
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure AI Search Documentation](https://docs.microsoft.com/en-us/azure/search/)
- [Cosmos DB Documentation](https://docs.microsoft.com/en-us/azure/cosmos-db/)

## ⚠️ Notes

- Ensure proper JSON configurations for datasource, index, and indexer
- Consider using managed identity for secure data source connections
- Review index configuration for optimal search performance
- The module uses the REST API provider to interact with Azure AI Search
