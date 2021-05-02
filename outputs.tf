output "insights_read_telemetry_api_key" {
  value = azurerm_application_insights_api_key.read_telemetry.api_key
  sensitive = true
}

output "insights_application_id" {
  value= azurerm_application_insights.main.id
}
