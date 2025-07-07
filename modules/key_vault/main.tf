resource "azurerm_key_vault" "this" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
}

resource "azurerm_key_vault_secret" "databricks_pat" {
  name         = "databricks-pat"
  value        = var.databricks_pat
  key_vault_id = azurerm_key_vault.this.id
}
