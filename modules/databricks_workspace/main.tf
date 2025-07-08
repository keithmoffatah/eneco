resource "databricks_cluster" "shared" {
  cluster_name            = "Shared-Cluster"
  spark_version           = "13.3.x-scala2.12"
  node_type_id            = "Standard_DC1s_v3" # or "Standard_DS3_v2"
  autotermination_minutes = 60
  num_workers             = 1
}
