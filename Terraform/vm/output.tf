output "vm_id" {
  description = "The ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.my_terraform_vm.id
}


output "vm_name" {
  description = "The name of the virtual machine"
  value       = azurerm_linux_virtual_machine.my_terraform_vm.name
}