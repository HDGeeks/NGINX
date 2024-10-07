# Data source to get the current Azure client configuration
data "azurerm_client_config" "current" {}

# Create a random suffix for Key Vault name to ensure it is unique
resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

# Azure Key Vault
resource "azurerm_key_vault" "demo-key-vault" {
  name                = "mykeyvault${random_integer.suffix.result}" # Ensure unique name
  location            = azurerm_resource_group.rg_container.location
  resource_group_name = azurerm_resource_group.rg_container.name
  sku_name            = "standard"

  tenant_id = data.azurerm_client_config.current.tenant_id

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_user_assigned_identity.principal_identity.principal_id

    key_permissions = [
      "get",
      "list"
    ]

    secret_permissions = [
      "get",
      "list",
      "set",  # Only valid permissions for secrets
      "delete"
    ]

    storage_permissions = [
      "get",
      "list",
      "set",
      "delete",
      "update"  # Only valid permissions for storage
    ]
  }
}

# Create a secret in Key Vault for the ACR admin password
resource "azurerm_key_vault_secret" "acr_admin_password" {
  name         = "acr-admin-password"
  value        = azurerm_container_registry.my-demo-acr.admin_password
  key_vault_id = azurerm_key_vault.demo-key-vault.id
}

# Create a secret in Key Vault for the ACR admin username
resource "azurerm_key_vault_secret" "acr_admin_username" {
  name         = "acr-admin-username"
  value        = azurerm_container_registry.my-demo-acr.admin_username
  key_vault_id = azurerm_key_vault.demo-key-vault.id
}
