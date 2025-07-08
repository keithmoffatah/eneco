# RBAC module: Defines Databricks user groups, assigns users to groups, and manages cluster permissions.
# This enables secure, role-based access control for multiple teams in the Databricks workspace.
# Admins, data engineers, and data scientists are managed via variables and assigned to their respective groups.

resource "databricks_group" "admins" {
  display_name = "Admins"
}

resource "databricks_group" "data_engineers" {
  display_name = "Data Engineers"
}

resource "databricks_group" "data_scientists" {
  display_name = "Data Scientists"
}

resource "databricks_user" "admin_users" {
  for_each  = toset(var.admin_users)
  user_name = each.key
}

resource "databricks_user" "data_engineer_users" {
  for_each  = toset(var.data_engineer_users)
  user_name = each.key
}

resource "databricks_user" "data_scientist_users" {
  for_each  = toset(var.data_scientist_users)
  user_name = each.key
}

resource "databricks_group_member" "admins_membership" {
  for_each  = databricks_user.admin_users
  group_id  = databricks_group.admins.id
  member_id = each.value.id
}

resource "databricks_group_member" "data_engineers_membership" {
  for_each  = databricks_user.data_engineer_users
  group_id  = databricks_group.data_engineers.id
  member_id = each.value.id
}

resource "databricks_group_member" "data_scientists_membership" {
  for_each  = databricks_user.data_scientist_users
  group_id  = databricks_group.data_scientists.id
  member_id = each.value.id
}

data "databricks_service_principal" "spn_eneco" {
  application_id = var.spn_application_id
}

resource "databricks_group_member" "spn_admin" {
  group_id  = databricks_group.admins.id
  member_id = data.databricks_service_principal.spn_eneco.id
}

resource "databricks_permissions" "cluster_access" {
  count      = var.cluster_id != "" ? 1 : 0
  cluster_id = var.cluster_id

  access_control {
    group_name       = databricks_group.admins.display_name
    permission_level = "CAN_MANAGE"
  }

  access_control {
    group_name       = databricks_group.data_engineers.display_name
    permission_level = "CAN_ATTACH_TO"
  }

  access_control {
    group_name       = databricks_group.data_scientists.display_name
    permission_level = "CAN_ATTACH_TO"
  }
}
