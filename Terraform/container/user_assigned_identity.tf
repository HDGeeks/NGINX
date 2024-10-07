# user_assigned_identity.tf
resource "azurerm_user_assigned_identity" "principal_identity" {
  name                = "myUserAssignedIdentity"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}


