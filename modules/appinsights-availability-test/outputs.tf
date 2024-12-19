
output "id" {
    value = azurerm_application_insights_standard_web_test.appinsights_standard_availability_test.id
}

output "name" {
    value = azurerm_application_insights_standard_web_test.appinsights_standard_availability_test.name
}

output "alert_id" {
    value = var.create_alert ? azurerm_monitor_metric_alert.appinsights_standard_availability_test_alert[0].id : null
}

output "alert_name" {
    value = var.create_alert ? azurerm_monitor_metric_alert.appinsights_standard_availability_test_alert[0].name : null
}