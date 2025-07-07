output "admin_group_id" {
  description = "ID of the Admins group"
  value       = databricks_group.admins.id
}

output "data_engineers_group_id" {
  description = "ID of the Data Engineers group"
  value       = databricks_group.data_engineers.id
}

output "data_scientists_group_id" {
  description = "ID of the Data Scientists group"
  value       = databricks_group.data_scientists.id
}
