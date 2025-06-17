# To do https://learn.microsoft.com/en-us/rest/api/searchservice/create-data-source
resource "restapi_object" "cosmos_datasource" {
  path         = "/datasources"
  query_string = "api-version=2024-07-01"
  data         = var.cosmos_datasource_json
  id_attribute = "name" # The ID field on the response
}


# To do this: https://learn.microsoft.com/en-us/rest/api/searchservice/preview-api/create-or-update-index
resource "restapi_object" "cosmos_standard_lucene_index" {
  path         = "/indexes"
  query_string = "api-version=2024-07-01"
  data         = var.cosmos_standard_lucene_index_json
  id_attribute = "name" # The ID field on the response

  depends_on = [restapi_object.cosmos_datasource]
}

# To do https://learn.microsoft.com/en-us/rest/api/searchservice/create-indexer
resource "restapi_object" "cosmos_standard_lucene_indexer" {
  path         = "/indexers"
  query_string = "api-version=2024-07-01"
  data         = var.cosmos_standard_lucene_indexer_json
  id_attribute = "name" # The ID field on the response

  depends_on = [restapi_object.cosmos_datasource, restapi_object.cosmos_standard_lucene_index]
}

resource "azurerm_role_assignment" "search_index_reader" {
  for_each = toset(var.search_index_reader_role_assignment)

  principal_id = each.value.principal_id
  role_definition_name = "Search Index Data Reader"
  scope = var.azureai_account_id

  depends_on = [restapi_object.cosmos_standard_lucene_indexer]
}

