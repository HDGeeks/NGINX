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

# Include other modules or resources
module "network" {
  source = "./network"
}

output "network_rg_name" {
  value = module.network.resource_group_name
}

output "network_rg_location" {
  value = module.network.resource_group_location
}
output "network_rg_id" {
  value = module.network.resource_group_id  
}

output "ssh_public_key" {
  value = module.ssh.ssh_public_key  # Output the SSH public key for reference
}

output "storage_account_uri" {
  value = module.storage.storage_account_uri  # Output the storage account URI for reference
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
  depends_on = [ module.network ]

}
