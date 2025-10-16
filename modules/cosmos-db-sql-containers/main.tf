resource "azurerm_cosmosdb_sql_container" "sql_containers" {
  for_each = tomap({
    for container in var.containers :
    container.name => container
  })

  name                  = each.value.name
  resource_group_name   = var.resource_group_name
  account_name          = var.cosmosdb_account_name
  database_name         = var.database_name
  partition_key_paths   = each.value.partition_key_paths
  partition_key_version = each.value.partition_key_version == null ? 1 : each.value.partition_key_version
  throughput            = each.value.throughput == null ? null : each.value.throughput

  indexing_policy {
    indexing_mode = each.value.indexing_mode == null ? "consistent" : each.value.indexing_mode

    included_path {
      path = each.value.indexing_path == null ? "/*" : each.value.indexing_path
    }
  }

  dynamic "unique_key" {
    for_each = each.value.unique_key_paths != null && length(each.value.unique_key_paths) > 0 ? [each.value.unique_key_paths] : []
    content {
      paths = each.value.unique_key_paths
    }
  }
}