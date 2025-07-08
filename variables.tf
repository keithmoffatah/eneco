variable "workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
}

variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "storage_container_name" {
  description = "Name of the default storage container"
  type        = string
}

variable "admin_users" {
  description = "List of admin user emails"
  type        = list(string)
}

variable "data_engineer_users" {
  description = "List of data engineer user emails"
  type        = list(string)
}

variable "data_scientist_users" {
  description = "List of data scientist user emails"
  type        = list(string)
}

variable "spn_application_id" {
  description = "The Application (client) ID of the Databricks service principal to be created and assigned as admin."
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

// these variable is used for OIDC authentication withim Databricks
variable "tenant_id" {
  description = "Azure Tenant ID for OIDC authentication with Databricks."
  type        = string
}

variable "databricks_workspace_resource_id" {
  description = "The Azure resource ID of the Databricks workspace."
  type        = string
}

variable "databricks_host" {
  description = "The URL of the Databricks workspace (e.g., https://adb-xxxx.westeurope.azuredatabricks.net)."
  type        = string
}
