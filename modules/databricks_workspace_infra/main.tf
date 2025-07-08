# This module provisions the Azure Databricks workspace infrastructure (resource group, workspace) with the required configuration for multi-team use.
# It outputs the workspace resource ID and URL for use by other modules (e.g., Databricks API, RBAC).

resource "azurerm_databricks_workspace" "main" {
  name                = var.workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "premium"
}
