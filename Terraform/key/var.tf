variable "key_vault_name" {
  type        = string
  description = "The name of the Key Vault."
  default = "my-key-vault"
}

variable "resource_group_location" {
  type        = string
  description = "The location for the Key Vault."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID for the Key Vault."
}

variable "object_id" {
  type        = string
  description = "Object ID of the user or service principal."
}

variable "acr_admin_password" {
  type        = string
  description = "ACR admin password to store as secret."
  default = "admin"
}

variable "acr_admin_username" {
  type        = string
  description = "ACR admin username to store as secret."
  default = "password"
}
