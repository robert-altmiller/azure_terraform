
# required terraform providers
terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
  required_version = ">=0.13"
}


# setup the databricks workspace terraform provider
provider "databricks" { 
    alias = "workspace"
    host = local.workspace_instance_url
    token = data.external.get_account_token.result["token"]
}