# Cosmos DB SQL Role Assignments module

This module manages role assignments for an existing Azure Cosmos DB SQL database resource. It creates role assignments scoped to the database resource ID you provide.

## What this module does 🚀

- Create role assignments for a Cosmos DB SQL database

## Pre-requisites ⚙️

- The target Cosmos DB account and SQL database must already exist. This module requires the database resource ID.
- Terraform and Azure credentials configured

## Inputs (variables) 🧾

The module expects the following variables (defined in `variables.tf`):

- `resource_group_name` (string) - Resource group where the Cosmos DB account lives
- `cosmosdb_account_name` (string) - Cosmos DB account name
- `database_id` (string) - Full resource ID of the Cosmos DB SQL database to scope role assignments to
- `database_role_assignments` (list(object), default = []) - List of role assignment objects with the schema:

  - `name` (string) - A short name for the assignment (used as the Terraform resource name)
  - `role_definition_id` (string) - The role definition id or the fully qualified role definition resource id
  - `principal_id` (string) - The principal (service principal, user or managed identity) object id to assign the role to

Example:

```
database_role_assignments = [
  {
    name               = "db-contributor"
    role_definition_id = "/subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Authorization/roleDefinitions/00000000-0000-0000-0000-000000000000"
    principal_id       = "11111111-1111-1111-1111-111111111111"
  }
]
```

## Usage example 📦

```hcl
module "cosmos_db_role_assignments" {
  source = "../cosmos-db-sql-role-assignments"

  resource_group_name = var.resource_group_name
  cosmosdb_account_name = var.cosmosdb_account_name
  database_id = 
    "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-rg/providers/Microsoft.DocumentDB/databaseAccounts/my-account/sqlDatabases/my-database"

  database_role_assignments = [
    {
      name               = "db-reader"
      role_definition_id = "<role-definition-id>"
      principal_id       = "<principal-object-id>"
    }
  ]
}
```

## Notes ⚠️

- `database_id` must be the full resource ID for the database (not just the name).
- Role assignment names must be unique within the Terraform state for this module.
- Be careful when assigning permissions; prefer least-privilege roles.

- See the `cosmos-db-sql-db` module for database creation and `cosmos-db-sql-containers` for container management.
## Related 🔗

- `cosmos-db-sql-db` (database creation & throughput): [cosmos-db-sql-db/readme.md](../cosmos-db-sql-db/readme.md)
- `cosmos-db-sql-containers` (container management): [cosmos-db-sql-containers/readme.md](../cosmos-db-sql-containers/readme.md)
- See the `cosmos-db-sql-db` module for database creation and `cosmos-db-sql-containers` for container management.

