

# Create a random suffix for Key Vault name to ensure it is unique
resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

# Azure Key Vault
resource "azurerm_key_vault" "key-for-acr" {
  name                = "mykeyvault${random_integer.suffix.result}" # Ensure unique name
  location            = var.resource_group_location
  resource_group_name = var. resource_group_name 
  sku_name            = "standard"

  tenant_id = data.azurerm_client_config.current.tenant_id

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "get",
      "list",
    ]
  }
}

# Create a secret in Key Vault for the ACR admin password
resource "azurerm_key_vault_secret" "acr_admin_password" {
  name         = "acr-admin-password"
  value        = azurerm_container_registry.my-demo-acr.admin_password
  key_vault_id = azurerm_key_vault.key-for-acr.id
}

# Create a secret in Key Vault for the ACR admin username
resource "azurerm_key_vault_secret" "acr_admin_username" {
  name         = "acr-admin-username"
  value        = azurerm_container_registry.my-demo-acr.admin_username
  key_vault_id = azurerm_key_vault.key-for-acr.id
}
