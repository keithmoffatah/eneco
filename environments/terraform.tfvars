workspace_name         = "prod-databricks-workspace"
resource_group_name    = "rg-databricks"
location               = "westeurope"
storage_account_name   = "prodsa123456"
storage_container_name = "team-data"

admin_users            = ["admin1@example.com"]
data_engineer_users    = ["de1@example.com"]
data_scientist_users   = ["ds1@example.com"]
subscription_id        = "1aa834b1-9a6a-496a-ab19-65baadf580e4"
spn_application_id     = "c28fa970-4a8d-4802-8e81-80ecdfaaed74"
tenant_id              = "9c27bd1f-0a00-494d-ac12-70555bcb3b00"
databricks_workspace_resource_id = "dummy"
databricks_host        = "https://dummy"