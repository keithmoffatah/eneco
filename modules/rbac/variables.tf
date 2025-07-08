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

variable "cluster_id" {
  description = "ID of the Databricks cluster to manage permissions"
  type        = string
}

variable "spn_application_id" {
  description = "The Application (client) ID of the Databricks service principal."
  type        = string
}
