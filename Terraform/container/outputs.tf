

output "staging_container_ip" {
  value = azurerm_container_group.staging.ip_address
}

output "production_container_ip" {
  value = azurerm_container_group.production.ip_address
}

output "acr_login_server" {
  value = azurerm_container_registry.my-demo-acr.login_server
}

output "current_tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "current_object_id" {
  value = data.azurerm_client_config.current.object_id
}

output "current_client_id" {
  value = data.azurerm_client_config.current.client_id
}
# Output the principal_id
output "principal_id" {
  value = azurerm_user_assigned_identity.principal_identity.principal_id
}



