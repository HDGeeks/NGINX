
output "storage_account_uri" {
  description = "The primary blob endpoint of the storage account"
  value       = azurerm_storage_account.my_storage_account.primary_blob_endpoint
}
