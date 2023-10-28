data "external" "get_account_token" {
  program = ["python3", "./get_databricks_token.py"]
  query = {
    tenant_id = local.azure_tenant
    client_id = local.account_sp_client_id
    client_secret = local.account_sp_client_secret
    resource_id = "2ff814a6-3304-4ab8-85cb-cd0e6f879c1d" # does not change (Azure Databricks app's Azure AD identifier)
  }
}