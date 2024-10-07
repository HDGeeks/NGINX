output "user_identity_id" {
  value       = azurerm_user_assigned_identity.user_identity.id
  description = "The ID of the user assigned identity."
}

output "user_identity_principal_id" {
  value       = azurerm_user_assigned_identity.user_identity.principal_id
  description = "The principal ID of the user assigned identity."
}

