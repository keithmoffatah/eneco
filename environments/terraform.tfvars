workspace_name         = "prod-databricks-workspace"
resource_group_name    = "rg-databricks"
location               = "westeurope"
storage_account_name   = "prodsa123456"
storage_container_name = "team-data"

admin_users            = ["admin1@example.com"]
data_engineer_users    = ["de1@example.com"]
data_scientist_users   = ["ds1@example.com"]
subscription_id        = "1aa834b1-9a6a-496a-ab19-65baadf580e4"