
# Data source to get the current Azure client configuration
data "azurerm_client_config" "current" {}


resource "azurerm_user_assigned_identity" "user_identity" {
  name                = var.user_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
}

resource "azurerm_role_assignment" "acr_access" {
  principal_id   = azurerm_user_assigned_identity.user_identity.principal_id
  role_definition_name = "AcrPull"
  scope          = var.acr_id
}

resource "azurerm_role_assignment" "key_vault_access" {
  principal_id   = azurerm_user_assigned_identity.user_identity.principal_id
  role_definition_name = "Key Vault Secrets User"
  scope          = var.key_vault_id
}
