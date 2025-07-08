resource "databricks_cluster" "shared" {
  cluster_name            = "Shared-Cluster"
  spark_version           = "13.3.x-scala2.12"
  node_type_id            = "Standard_DS3_v2"
  autotermination_minutes = 60
  // Update num_workers when not using free azure
  num_workers             = 0
}
