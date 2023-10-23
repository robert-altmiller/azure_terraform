# required terraform providers
terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      version = "1.28.1"
    }
  }
}


# setup the databricks workspace terraform provider
provider "databricks" { 
    alias = "workspace"
    host = local.workspace_instance_url
    token = data.external.get_account_token.result["token"]
}


# setup the databricks account terraform provider
provider "databricks" { 
    alias = "mws"
    account_id = local.account_id
    host = local.account_url
    token = data.external.get_account_token.result["token"]
}


