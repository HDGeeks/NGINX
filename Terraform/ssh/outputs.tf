
output "ssh_public_key" {
  description = "The public SSH key generated"
  value       = azapi_resource_action.ssh_public_key_gen.output.publicKey
}



