
variable "resource_group_location" {
  type        = string
  default     = "Germany West Central"  # Updated to a region in Germany
  description = "Location of the resource group."
}


variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}



variable "resource_group_name" {
  type        = string
  description = "Demo resource group."
  default     = "Demo_resource_group"
}

variable "domain_name_label" {
  type        = string
  description = "The dns label for the ipv4"
  default     = "cgi-vm-demo1"
}
