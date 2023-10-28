# get an existing workspace group name (users)
data "databricks_group" "existing_group_users_workspace" {
  provider = databricks.workspace
  display_name = local.workspace_contributor_aad_group
}


# add entitlements to the account level aad contributors group in the workspace
# this can only be done once the account level group is added to the workspace
resource "databricks_entitlements" "existing_group_users_entitlements" {
  depends_on = [data.databricks_group.existing_group_users_workspace]
  provider = databricks.workspace
  group_id                   = data.databricks_group.existing_group_users_workspace.id
  workspace_access           = true
  databricks_sql_access      = true
}
