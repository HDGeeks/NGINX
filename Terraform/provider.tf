terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }

  required_version = ">= 1.0"
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



module "vm" {
  source = "./vm"
  depends_on = [module.network,module.storage,module.ssh]
}

module "storage" {
  source = "./storage"
  depends_on = [module.vm,module.network]
}

module "ssh" {
  source = "./ssh"
  depends_on = [module.network]
  resource_group_location = module.network.resource_group_location
  resource_group_name = module.network.resource_group_name
  resource_group_id = module.network.resource_group_id





}
