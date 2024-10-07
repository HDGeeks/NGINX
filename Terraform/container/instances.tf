




# Staging Environment
resource "azurerm_container_group" "staging" {
  name                = "staging-environment"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  restart_policy      = var.restart_policy
  ip_address_type     = "Private"
  network_profile_id  = var.network_profile_id

 

  container {
    name   = "staging-container"
    image  = "${var.image}/my-app:latest"
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

    ports {
      port     = var.port
      protocol = "TCP"
    }

    environment_variables = {
      ENV           = "staging"
      ACR_USERNAME   = var.acr_user  # Ensure correct module reference
      ACR_PASSWORD   = var.acr_password # Ensure correct module reference
    }
  }

  tags = {
    environment = "staging"
  }
}

# Production Environment
resource "azurerm_container_group" "production" {
  name                = "production-environment"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  restart_policy      = var.restart_policy
  ip_address_type     = "Private"
  network_profile_id  = var.network_profile_id



  container {
    name   = "production-container"
    image  = "${var.image}/my-app:latest"
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

    ports {
      port     = var.port
      protocol = "TCP"
    }

    environment_variables = {
      ENV           = "production"
      ACR_USERNAME   = var.acr_user # Ensure correct module reference
      ACR_PASSWORD   = var.acr_password  # Ensure correct module reference
    }
  }

  tags = {
    environment = "production"
  }
}
