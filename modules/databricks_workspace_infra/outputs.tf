output "workspace_resource_id" {
  value = azurerm_databricks_workspace.main.id
}

output "workspace_url" {
  value = "https://${azurerm_databricks_workspace.main.workspace_url}"
}
