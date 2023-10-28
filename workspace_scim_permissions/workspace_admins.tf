# get an existing workspace system group name (admins)
data "databricks_group" "system_group_admins_workspace" {
  provider = databricks.workspace
  display_name = "admins"
}


# get an existing workspace aad group name (admins)
# for workspace level scim this will already exist
data "databricks_group" "existing_group_admins_workspace" {
  provider = databricks.workspace
  display_name = local.workspace_admin_aad_group
}


# add all entitlements to the workspace level aad admin group in the workspace
# this can only be done after workspace level scim integration is running
resource "databricks_entitlements" "existing_group_admins_entitlements" {
  depends_on = [data.databricks_group.existing_group_admins_workspace]
  provider                   = databricks.workspace
  group_id                   = data.databricks_group.existing_group_admins_workspace.id
  workspace_access           = true
  databricks_sql_access      = true
  allow_cluster_create       = true
  allow_instance_pool_create = true
}