# outputs.tf
output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "staging_container_ip" {
  value = azurerm_container_group.staging.ip_address
}

output "production_container_ip" {
  value = azurerm_container_group.production.ip_address
}

