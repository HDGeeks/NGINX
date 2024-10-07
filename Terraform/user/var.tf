variable "user_name" {
  type        = string
  description = "The name of the user identity."
  default = "admin"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "resource_group_location" {
  type        = string
  description = "The location for the user identity."
}

variable "acr_id" {
  type        = string
  description = "The ID of the ACR for assigning permissions."
}

variable "key_vault_id" {
  type        = string
  description = "The ID of the Key Vault for assigning permissions."
}
