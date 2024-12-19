
output "id" {
    value = azurerm_application_insights_standard_web_test.appinsights_standard_availability_test.id
}

output "name" {
    value = azurerm_application_insights_standard_web_test.appinsights_standard_availability_test.name
}


output "alert_id" {
    value = var.enable_alert ? azurerm_monitor_metric_alert.appinsights_standard_availability_test_alert.id : null
}

output "alert_name" {
    value = var.enable_alert ? azurerm_monitor_metric_alert.appinsights_standard_availability_test_alert.name : null
}