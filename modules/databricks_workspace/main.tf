resource "azurerm_databricks_workspace" "main" {
  name                = var.workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "premium"
}

resource "databricks_cluster" "shared" {
  cluster_name            = "Shared-Cluster"
  spark_version           = "13.3.x-scala2.12"
  node_type_id            = "Standard_DS2_v2"
  autotermination_minutes = 60
  num_workers             = 1
}
