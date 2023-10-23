# get an existing account group name (admins)
data "databricks_group" "existing_group_admins_account" {
  provider = databricks.mws
  display_name = local.workspace_admin_aad_group
}


# get an existing workspace group name (admins)
data "databricks_group" "existing_group_admins_workspace" {
  depends_on = [databricks_mws_permission_assignment.add_existing_group_admins]
  provider = databricks.workspace
  display_name = local.workspace_admin_aad_group
}


# add account level aad admin group as a workspace admin
resource "databricks_mws_permission_assignment" "add_existing_group_admins" {
  provider     = databricks.mws
  workspace_id = local.workspace_id
  principal_id = data.databricks_group.existing_group_admins_account.id
  permissions  = ["ADMIN"]
}


# add all entitlements to the account level aad admin group in the workspace
# this can only be done once the account level group is added to the workspace
resource "databricks_entitlements" "existing_group_admins_entitlements" {
  depends_on = [databricks_mws_permission_assignment.add_existing_group_admins]
  provider                   = databricks.workspace
  group_id                   = data.databricks_group.existing_group_admins_workspace.id
  workspace_access           = true
  databricks_sql_access      = true
  allow_cluster_create       = true
  allow_instance_pool_create = true
}