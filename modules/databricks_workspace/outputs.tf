output "workspace_url" {
  value = azurerm_databricks_workspace.main.workspace_url
}

output "cluster_id" {
  value = databricks_cluster.shared.id
}
