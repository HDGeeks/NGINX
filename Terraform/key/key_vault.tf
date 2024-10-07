resource "azurerm_key_vault" "demo_key_vault" {
  name                = var.key_vault_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = var.tenant_id

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id 

    secret_permissions = [
      "get",
      "list",
      "set",
      "delete",
    ]
  }
}

# Store ACR admin credentials in Key Vault
resource "azurerm_key_vault_secret" "acr_admin_password" {
  name         = "acr-admin-password"
  value        = var.acr_admin_password
  key_vault_id = azurerm_key_vault.demo_key_vault.id
}

resource "azurerm_key_vault_secret" "acr_admin_username" {
  name         = "acr-admin-username"
  value        = var.acr_admin_username
  key_vault_id = azurerm_key_vault.demo_key_vault.id
}
