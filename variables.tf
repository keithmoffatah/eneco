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
