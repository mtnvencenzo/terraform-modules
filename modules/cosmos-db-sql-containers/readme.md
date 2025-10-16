# Cosmos DB SQL Containers module

This module manages SQL containers for an existing Azure Cosmos DB SQL database. It does not create the database or the Cosmos DB account itself — use the database/account module for those.

## What this module does 🚀

- Create one or more SQL containers under an existing database
- Configure partition key(s), optional throughput and indexing settings

## Pre-requisites ⚙️

- An existing Cosmos DB account and SQL database
- Terraform and Azure credentials configured

## Inputs (variables) 🧾

The module expects the following variables (defined in `variables.tf`):

- `resource_group_name` (string) - Resource group where the Cosmos DB account lives
- `cosmosdb_account_name` (string) - Cosmos DB account name
- `database_name` (string) - Name of the existing SQL database
- `containers` (list(object), default = []) - List of container objects with the schema:

  - `name` (string) - Container name
  - `partition_key_paths` (list(string)) - Partition key path(s), e.g. ["/partitionKey"]
  - `partition_key_version` (number, optional) - Version of the partition key
  - `throughput` (number, optional) - Manual throughput for the container (RU/s)
  - `indexing_mode` (string, optional) - Indexing mode (for example "consistent")
  - `indexing_path` (string, optional) - Indexing path (for example "/*")
  - `unique_key_paths` (list(string)) - Unique key paths

Example container object:

```
{
  name                = "container1"
  partition_key_paths = ["/partitionKey"]
  partition_key_version = 2
  throughput          = 400
  indexing_mode       = "consistent"
  indexing_path       = "/*"
  unique_key_paths    = ["/uniqueKey"]
}
```

## Usage example 📦

```hcl
module "cosmos_containers" {
  source                = "../cosmos-db-sql-containers"
  resource_group_name   = var.resource_group_name
  cosmosdb_account_name = var.cosmosdb_account_name
  database_name         = "existing-db"
  containers = [
    {
      name                = "items"
      partition_key_paths = ["/tenantId"]
      throughput          = 400
      unique_key_paths    = ["/id"]
    }
  ]
}
```

## Notes ⚠️

- This module assumes the SQL database already exists. Provide the exact `database_name`.
- If `throughput` is not provided for a container, it will use the database-level throughput if available.
- Validate partition key choices for data distribution and cost.

## Related 🔗

- See the `cosmos-db-sql-db` module for creating databases and assigning throughput: [cosmos-db-sql-db/readme.md](../cosmos-db-sql-db/readme.md)


