// modules/ssh/variables.tf
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

variable "vm_public_ip" {
  description = "The public IP address of the VM"
  type        = string
}

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "azureadmin"
}