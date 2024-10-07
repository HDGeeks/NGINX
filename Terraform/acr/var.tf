variable "acr_name" {
  type        = string
  description = "The name of the Azure Container Registry."
  default = "my-demo-acr"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "resource_group_location" {
  type        = string
  description = "The location for the ACR."
}
