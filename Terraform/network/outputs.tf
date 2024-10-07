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


output "network_interface_id" {
  value = azurerm_network_interface.my_terraform_nic.id
}

output "full_dns_label" {
  value = "${var.domain_name_label}.germanywestcentral.cloudapp.azure.com"
}


output "vnet_name" {
  value = azurerm_virtual_network.demo_virtual_network.name
}

output "vnet_address_space" {
  value = azurerm_virtual_network.demo_virtual_network.address_space
}

output "vnet_id" {
  value = azurerm_virtual_network.demo_virtual_network.id
}

output "vnet_location" {
  value = azurerm_virtual_network.demo_virtual_network.location
}


output "demo_subnet_id" {
  value = azurerm_subnet.demo_subnet.id
}

output "demo_subnet_containers_id" {
  value = azurerm_subnet.demo_subnet_containers.id
}



output "network_profile_id" {
  value = azurerm_network_profile.container-profile.id
}












