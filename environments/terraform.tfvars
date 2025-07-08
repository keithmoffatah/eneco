workspace_name         = "prod-databricks-workspace"
resource_group_name    = "rg-databricks"
location               = "westeurope"
storage_account_name   = "prodsa123456"
storage_container_name = "team-data"

admin_users            = ["admin1@example.com"]
data_engineer_users    = ["de1@example.com", "de2@example.com"]
data_scientist_users   = ["ds1@example.com"]

databricks_token       = "YOUR_DATABRICKS_PAT"
key_vault_name         = "keith-eneco-123"
tenant_id              = "9c27bd1f-0a00-494d-ac12-70555bcb3b00"