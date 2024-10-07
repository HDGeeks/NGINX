output "key_vault_id" {
  value       = azurerm_key_vault.demo_key_vault.id
  description = "The ID of the Key Vault."
}

output "key_vault_name" {
  value       = azurerm_key_vault.demo_key_vault.name
  description = "The name of the Key Vault."
}

output "acr_admin_password_secret_id" {
  value       = azurerm_key_vault_secret.acr_admin_password.id
  description = "The ID of the ACR admin password secret."
}

output "acr_admin_username_secret_id" {
  value       = azurerm_key_vault_secret.acr_admin_username.id
  description = "The ID of the ACR admin username secret."
}
