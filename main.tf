# The following backend "azurerm" block configures remote state storage in Azure Blob Storage.
# It is currently commented out. Uncomment and fill in the values to enable remote state.
# This is recommended for team environments or production use to avoid local state issues.
# For more info: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_storage_account

# terraform {
  # backend "azurerm" {
  #   resource_group_name  = "<RESOURCE_GROUP_NAME>"   # e.g. "my-tfstate-rg"
  #   storage_account_name = "<STORAGE_ACCOUNT_NAME>"  # e.g. "mystatestorageacct"
  #   container_name       = "<CONTAINER_NAME>"        # e.g. "tfstate"
  #   key                  = "terraform.tfstate"       # or another name if you prefer
  # }
#}

module "databricks_workspace" {
  source              = "./modules/databricks_workspace"
  workspace_name      = var.workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location

}

module "storage_account" {
  source               = "./modules/storage_account"
  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_name = var.storage_account_name
  container_name       = var.storage_container_name
}

module "rbac" {
  source               = "./modules/rbac"
  admin_users          = var.admin_users
  data_engineer_users  = var.data_engineer_users
  data_scientist_users = var.data_scientist_users
  cluster_id           = module.databricks_workspace.cluster_id  # if you output it
}

module "key_vault" {
  source              = "./modules/key_vault"
  key_vault_name      = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
}