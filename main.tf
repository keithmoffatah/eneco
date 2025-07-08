# The following backend "azurerm" block configures remote state storage in Azure Blob Storage.
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraformstate"   # e.g. "my-tfstate-rg"
    storage_account_name = "keithsterraformstate"  # e.g. "mystatestorageacct"
    container_name       = "keithsterraformstate"        # e.g. "tfstate"
    key                  = "terraform.tfstate"       # or another name if you prefer
  }
}

// Moved resource group creation to main.tf to ensure it exists before other resources are created.
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

module "databricks_workspace_infra" {
  source              = "./modules/databricks_workspace_infra"
  workspace_name      = var.workspace_name
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
}

module "databricks_workspace" {
  source              = "./modules/databricks_workspace"
  workspace_name      = var.workspace_name
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  workspace_resource_id = module.databricks_workspace_infra.workspace_resource_id
  workspace_url        = module.databricks_workspace_infra.workspace_url
}

module "storage_account" {
  source               = "./modules/storage_account"
  resource_group_name  = azurerm_resource_group.main.name
  location             = var.location
  storage_account_name = var.storage_account_name
  container_name       = var.storage_container_name
}

module "rbac" {
  source               = "./modules/rbac"
  admin_users          = var.admin_users
  data_engineer_users  = var.data_engineer_users
  data_scientist_users = var.data_scientist_users
  cluster_id           = module.databricks_workspace.cluster_id
  spn_application_id   = var.spn_application_id
}

# --- Databricks Service Principal and Admin Assignment ---
# The Terraform identity must be a Databricks workspace admin for this to succeed.
# resource "databricks_service_principal" "spn_eneco" {
#   application_id = var.spn_application_id  # Set this in your tfvars or pipeline secrets
#   display_name   = "spn-eneco"
# }

# Add the service principal to the workspace admins group
# resource "databricks_group_member" "spn_admin" {
#   group_id  = data.databricks_group.admins.id
#   member_id = databricks_service_principal.spn_eneco.id
# }

# data "databricks_group" "admins" {
#   display_name = "admins"
# }