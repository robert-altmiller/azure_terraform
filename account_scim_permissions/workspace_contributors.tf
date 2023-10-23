# get an existing account group name (users)
data "databricks_group" "existing_group_users_account" {
  provider = databricks.mws
  display_name = local.workspace_contributor_aad_group
}


# get an existing workspace group name (users)
data "databricks_group" "existing_group_users_workspace" {
  depends_on = [databricks_mws_permission_assignment.add_existing_group_users]
  provider = databricks.workspace
  display_name = local.workspace_contributor_aad_group
}


# add account level aad contributors group admin as a workspace user
resource "databricks_mws_permission_assignment" "add_existing_group_users" {
  provider = databricks.mws
  workspace_id = local.workspace_id
  principal_id = data.databricks_group.existing_group_users_account.id
  permissions  = ["USER"]
}


# add entitlements to the account level aad contributors group in the workspace
# this can only be done once the account level group is added to the workspace
resource "databricks_entitlements" "existing_group_users_entitlements" {
  depends_on = [databricks_mws_permission_assignment.add_existing_group_users]
  provider = databricks.workspace
  group_id                   = data.databricks_group.existing_group_users_workspace.id
  workspace_access           = true
  databricks_sql_access      = true
}
