output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
output "resource_group_location" {
  value = azurerm_resource_group.rg.location
}

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "public_ip" {
  value = azurerm_public_ip.my_vm_public_ip.ip_address
}

# network/outputs.tf
output "network_interface_id" {
  value = azurerm_network_interface.my_terraform_nic.id
}






