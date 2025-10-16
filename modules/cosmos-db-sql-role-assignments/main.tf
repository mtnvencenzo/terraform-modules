resource "azurerm_cosmosdb_sql_role_assignment" "sql_db_role_assignments" {
  for_each = tomap({
    for role_assignment in var.database_role_assignments :
    role_assignment.name => role_assignment
  })

  name                = each.value.name
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  role_definition_id  = each.value.role_definition_id
  principal_id        = each.value.principal_id
  scope               = replace(var.database_id, "sqlDatabases", "dbs")
}