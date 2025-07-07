output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = azurerm_key_vault.this.id
}

output "databricks_pat_secret_id" {
  description = "ID of the Databricks PAT secret"
  value       = azurerm_key_vault_secret.databricks_pat.id
}
