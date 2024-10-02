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

module "vm" {
  source = "./vm"
  depends_on = [module.network]
}

module "storage" {
  source = "./storage"
  depends_on = [module.vm]
}

module "ssh" {
  source = "./ssh"
  depends_on = [module.network]
}
