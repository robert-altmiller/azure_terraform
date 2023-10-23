# add workspace level service principal in the databricks workspace
resource "databricks_service_principal" "admin_sp" {
  provider = databricks.workspace
  application_id = local.workspace_admin_sp_client_id
}


# add account level service principal to account level aad admin group
resource "databricks_group_member" "add_sp_to_aad_admin" {
  provider = databricks.mws
  group_id = data.databricks_group.existing_group_admins_account.id
  member_id = databricks_service_principal.admin_sp.id
}


# add entitlements to the workspace level aad service principal in the workspace
# this can only be done once the account level service principle is added to the workspace
resource "databricks_entitlements" "existing_admin_sp_entitlements" {
  depends_on = [databricks_mws_permission_assignment.add_existing_group_users]
  provider = databricks.workspace
  service_principal_id       = databricks_service_principal.admin_sp.id
  workspace_access           = true
  allow_cluster_create       = true
  databricks_sql_access      = true
  allow_instance_pool_create = true
}
