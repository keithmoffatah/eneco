output "workspace_url" {
  value = module.databricks_workspace_infra.workspace_url
}

output "storage_account_name" {
  value = module.storage_account.storage_account_name
}

output "databricks_workspace_resource_id" {
  value = module.databricks_workspace_infra.workspace_resource_id
}

