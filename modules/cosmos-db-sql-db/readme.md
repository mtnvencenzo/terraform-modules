# Azure Cosmos DB SQL Database Module

This module creates and configures an Azure Cosmos DB SQL Database with role assignments and container configurations. It follows Azure best practices for database deployment and security.

## 🚀 Overview

The Cosmos DB SQL Database module provides a standardized way to deploy and manage SQL databases with:
- Database creation
- Role assignments
- Container configuration
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. An existing Cosmos DB account

## 📦 Usage

```hcl
module "cosmos_db_sql_db" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/cosmos-db-sql-db"

  # Required parameters
  database_name         = "mydatabase"
  resource_group_name   = "my-resource-group"
  cosmosdb_account_name = "mycosmosdbaccount"
  database_throughput   = 400

  # Role assignments
  database_role_assignments = [
    {
      name               = "role1"
      role_definition_id = "role-definition-id"
      principal_id       = "principal-id"
    }
  ]

  # Container configurations
  containers = [
    {
      name                = "container1"
      partition_key_paths = ["/partitionKey"]
      indexing_mode       = "consistent"
      indexing_path       = "/*"
      unique_key_paths    = ["/uniqueKey"]
    }
  ]

  tags = {
    Environment = "dev"
    Project     = "MyProject"
  }
}
```

## 📋 Required Parameters

| Name | Type | Description |
|------|------|-------------|
| database_name | string | Name of the SQL database |
| resource_group_name | string | Name of the resource group |
| cosmosdb_account_name | string | Name of the Cosmos DB account |
| database_throughput | number | Throughput for the database |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| database_role_assignments | list(object) | [] | List of role assignments |
| containers | list(object) | [] | List of container configurations |
| tags | map(string) | {} | Tags to apply to the database |

## 📤 Outputs

| Name | Description |
|------|-------------|
| database_name | Name of the created SQL database |
| database_id | Resource ID of the database |

## 🔒 Security Features

- Role assignments
- Container configuration
- Tagging for resource management

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Cosmos DB Documentation](https://docs.microsoft.com/en-us/azure/cosmos-db/)

## ⚠️ Notes

- Database names must be unique within the Cosmos DB account
- Review role assignments for your environment
- Ensure container configurations are properly set up
- Consider using private endpoints for enhanced security
