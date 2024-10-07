

# Resource Group
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
  restart_policy = var.restart_policy
  ip_address_type = "Public"
  network_profile_id = var.network_profile_id
  
  
  

  container {
    name   = "staging-container"
    image  = "${azurerm_container_registry.acr.login_server}/my-app:latest"
    cpu    = var.cpu_cores
    memory = var.memory_in_gb
    
   

    ports {
      port     = var.port
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

}

# Production Environment
resource "azurerm_container_group" "production" {
  name                = "production-environment"
  location            = azurerm_resource_group.rg_container.location
  resource_group_name = azurerm_resource_group.rg_container.name
  os_type             = "Linux"
  restart_policy      = var.restart_policy
  ip_address_type     = "Public"
  network_profile_id = var.network_profile_id
  
  

  container {
    name   = "production-container"
    image  = "${azurerm_container_registry.acr.login_server}/my-app:latest"
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

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

  

}
