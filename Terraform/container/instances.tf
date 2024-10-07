# Resource Group for Container
resource "azurerm_resource_group" "rg_container" {
  name     = "ServerlessDemo"
  location = var.resource_group_location
}

# Azure Container Registry (ACR)
resource "azurerm_container_registry" "my-demo-acr" {
  name                = "mydemoimagestore"
  resource_group_name = azurerm_resource_group.rg_container.name
  location            = azurerm_resource_group.rg_container.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Create container instances for both environments
# Staging Environment
resource "azurerm_container_group" "staging" {
  name                = "staging-environment"
  location            = azurerm_resource_group.rg_container.location
  resource_group_name = azurerm_resource_group.rg_container.name
  os_type             = "Linux"
  restart_policy      = var.restart_policy
  ip_address_type     = "Private" 
  network_profile_id  = var.network_profile_id

    depends_on = [
    azurerm_key_vault_secret.acr_admin_password,
    azurerm_key_vault_secret.acr_admin_username,
  ]

  container {
    name   = "staging-container"
    image  = "${azurerm_container_registry.my-demo-acr.login_server}/my-app:latest"
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

    ports {
      port     = var.port
      protocol = "TCP"
    }

    environment_variables = {
      ENV           = "staging"
      ACR_USERNAME   = azurerm_key_vault_secret.acr_admin_username.value
      ACR_PASSWORD   = azurerm_key_vault_secret.acr_admin_password.value
    }
  }

  tags = {
    environment = "staging"
  }
}

# Production Environment
resource "azurerm_container_group" "production" {
  name                = "production-environment"
  location            = azurerm_resource_group.rg_container.location
  resource_group_name = azurerm_resource_group.rg_container.name
  os_type             = "Linux"
  restart_policy      = var.restart_policy
  ip_address_type     = "Private"
  network_profile_id  = var.network_profile_id

    depends_on = [
    azurerm_key_vault_secret.acr_admin_password,
    azurerm_key_vault_secret.acr_admin_username,
  ]

  container {
    name   = "production-container"
    image  = "${azurerm_container_registry.my-demo-acr.login_server}/my-app:latest"
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

    ports {
      port     = var.port
      protocol = "TCP"
    }

    environment_variables = {
      ENV           = "production"
      ACR_USERNAME   = azurerm_key_vault_secret.acr_admin_username.value
      ACR_PASSWORD   = azurerm_key_vault_secret.acr_admin_password.value
    }
  }

  tags = {
    environment = "production"
  }
}
