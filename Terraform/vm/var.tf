

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "azureadmin"
}



variable "resource_group_name" {
  description = "The name of the resource group to use"
  type        = string

}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
}

variable "resource_group_id" {
  description = "The ID of the resource group to use"
  type        = string
}

// modules/vm/variables.tf
variable "ssh_public_key" {
  description = "The public SSH key to use for the VM"
  type        = string
}

variable "storage_account_uri" {
  description = "The URI of the storage account for boot diagnostics"
  type        = string
}

variable "vm_public_ip" {
  description = "The public IP address of the VM"
  type        = string
}

# vm/variables.tf
variable "network_interface_id" {
  description = "The ID of the network interface for the VM"
  type        = string
}


