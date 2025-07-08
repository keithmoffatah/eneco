resource "databricks_cluster" "shared" {
  count                   = 0 # Set to 1+ when clusters are allowed
  cluster_name            = "Shared-Cluster"
  spark_version           = "13.3.x-scala2.12"
  node_type_id            = "Standard_DS3_v2"
  autotermination_minutes = 60
  num_workers             = 0
}
