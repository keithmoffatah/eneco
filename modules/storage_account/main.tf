# This storage account is provisioned as Azure Data Lake Storage Gen2 (is_hns_enabled = true).
# It provides a shared data lake for all teams to store and share data and models securely.
# The default container is created for team collaboration and can be extended for more granular access if needed.
resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true  # Data Lake Gen2
}

resource "azurerm_storage_container" "this" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}
