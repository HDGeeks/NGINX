

# Resource Group
resource "azurerm_resource_group" "rg_container" {
  name     = "ServerlessDemo"
  location = var.resource_group_location
}

# Azure Container Registry (ACR) - Equivalent to ECR in AWS
resource "azurerm_container_registry" "acr" {
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

  container {
    name   = "staging-container"
    image  = "${azurerm_container_registry.acr.login_server}/my-app:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }

    environment_variables = {
      ENV = "staging"
    }
  }

  tags = {
    environment = "staging"
  }

  # Assuming VPC networking
  network_profile_id = module.my_terraform_network.id
}

# Production Environment
resource "azurerm_container_group" "production" {
  name                = "production-environment"
  location            = azurerm_resource_group.rg_container.location
  resource_group_name = azurerm_resource_group.rg_container.name
  os_type             = "Linux"

  container {
    name   = "production-container"
    image  = "${azurerm_container_registry.acr.login_server}/my-app:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }

    environment_variables = {
      ENV = "production"
    }
  }

  tags = {
    environment = "production"
  }

  # Assuming VPC networking
  network_profile_id = module.network_profile_id
}
