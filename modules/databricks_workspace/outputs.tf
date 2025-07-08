output "cluster_id" {
  value = length(databricks_cluster.shared) > 0 ? databricks_cluster.shared[0].id : ""
}
