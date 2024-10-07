terraform {
  required_version = ">=0.12"

  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Data source to get the current Azure client configuration
data "azurerm_client_config" "current" {}

# Include other modules or resources
module "network" {
  source = "./network"
}

module "vm" {
  source = "./vm"

  resource_group_id = module.network.resource_group_id
  resource_group_location = module.network.resource_group_location
  resource_group_name = module.network.resource_group_name
  ssh_public_key = module.ssh.ssh_public_key
  storage_account_uri = module.storage.storage_account_uri
  vm_public_ip = module.network.public_ip
  network_interface_id = module.network.network_interface_id 
  depends_on = [ module.network , module.ssh]
 
}

module "storage" {
  source = "./storage"
 
  resource_group_id = module.network.resource_group_id
  resource_group_location = module.network.resource_group_location
  resource_group_name = module.network.resource_group_name
}

module "ssh" {
  source = "./ssh"

  resource_group_location = module.network.resource_group_location
  resource_group_name = module.network.resource_group_name
  resource_group_id = module.network.resource_group_id
  vm_public_ip = module.network.public_ip
  domain_name_label = module.network.full_dns_label
  depends_on = [ module.network ]

}

module "container" {
  source = "./container"
  resource_group_location = module.network.resource_group_location
  network_profile_id = module.network.network_profile_id
  container-subnets = module.network.demo_subnet_containers_id
  resource_group_name = module.network.resource_group_name
  acr_password = module.key.acr_admin_password_secret_id
  acr_user = module.key.acr_admin_username_secret_id
  image = module.acr.acr_login_server
 

  
}

module "key" {
  source = "./key"

  resource_group_location = module.network.resource_group_location
  resource_group_name = module.network.resource_group_name
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = module.user.user_identity_principal_id

}

module "user" {
  source = "./user"
  resource_group_location = module.network.resource_group_location
  resource_group_name = module.network.resource_group_name
  acr_id = module.acr.acr_id
  key_vault_id = module.key.key_vault_id
  
}

module "acr" {
  source = "./acr"
  resource_group_name = module.network.resource_group_name
  resource_group_location = module.network.resource_group_location
  principal = module.user.user_identity_id
  
}

output "full_dns_label" {
  value = module.network.full_dns_label
}

