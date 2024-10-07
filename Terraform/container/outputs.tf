

output "staging_container_ip" {
  value = azurerm_container_group.staging.ip_address
}

output "production_container_ip" {
  value = azurerm_container_group.production.ip_address
}

output "acr_login_server" {
  value = azurerm_container_registry.my-demo-acr.login_server
}



