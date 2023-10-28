# add workspace level service principal in the databricks workspace
resource "databricks_service_principal" "admin_sp" {
  provider = databricks.workspace
  application_id = local.workspace_admin_sp_client_id
}


data "databricks_service_principal" "admin_sp_data" {
  depends_on = [databricks_service_principal.admin_sp]
  provider = databricks.workspace
  application_id = local.workspace_admin_sp_client_id
}


# add workspace admin service principal to workspace aad admin group
resource "databricks_group_member" "add_sp_to_aad_admin" {
  depends_on = [data.databricks_service_principal.admin_sp_data]
  provider = databricks.workspace
  group_id = data.databricks_group.existing_group_admins_workspace.id
  member_id = data.databricks_service_principal.admin_sp_data.id
}


# add workspace admin service principal to workspace system admins groups
resource "databricks_group_member" "add_group_to_admins" {
  depends_on = [data.databricks_service_principal.admin_sp_data]
  provider = databricks.workspace
  group_id  = data.databricks_group.system_group_admins_workspace.id
  member_id = data.databricks_service_principal.admin_sp_data.id
}


# add entitlements to the workspace level aad service principal
# this can only be done once the workspace level scim integration is running
resource "databricks_entitlements" "existing_admin_sp_entitlements" {
  depends_on = [data.databricks_service_principal.admin_sp_data]
  provider = databricks.workspace
  service_principal_id       = data.databricks_service_principal.admin_sp_data.id
  workspace_access           = true
  allow_cluster_create       = true
  databricks_sql_access      = true
  allow_instance_pool_create = true
}
