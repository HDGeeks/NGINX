provider "random" {}

# Create a random string for the Key Vault name suffix
resource "random_string" "key_vault_suffix" {
  length  = 8  # Length of the random suffix
  upper   = false  # Use lowercase letters
  lower   = true   # Use lowercase letters

  special = false   # No special characters
}

resource "azurerm_key_vault" "demo_key_vault" {
  name                = "${var.key_vault_name}${random_string.key_vault_suffix.result}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = var.tenant_id

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id 

   

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
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

# Store ACR admin credentials in Key Vault
resource "azurerm_key_vault_secret" "acr_admin_password" {
  name         = "acr-admin-password"
  value = "password"
  //value        = var.acr_admin_password
  key_vault_id = azurerm_key_vault.demo_key_vault.id
}

resource "azurerm_key_vault_secret" "acr_admin_username" {
  name         = "acr-admin-username"
  //value        = var.acr_admin_username
  value = "admin"
  key_vault_id = azurerm_key_vault.demo_key_vault.id
}
