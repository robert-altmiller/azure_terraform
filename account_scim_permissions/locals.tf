locals {
    # azure tenant id
    azure_tenant = ""
    

    # databricks account id
    account_id = "f4cd1c7f-add3-4d49-b836-9b594a648c54"
    # databricks account url
    account_url = "https://accounts.azuredatabricks.net"
    # account admin service principal client-id
    account_sp_client_id = ""
    #account admin service principal client-secret
    account_sp_client_secret = ""
    
    
    # workspace instance url
    workspace_instance_url = "https://adb-****************.4.azuredatabricks.net"
    # workspace id stripped off of the workspace_instance_url
    workspace_id = element(split(".", element(split("-", local.workspace_instance_url), 1)), 0)
    # workspace personal access token
    workspace_token = ""
    # workspace admin service principal client-id
    workspace_admin_sp_client_id = ""
    # workspace admin service principal client-secret
    workspace_admin_sp_client_secret = ""


    # workspace admin aad group
    workspace_admin_aad_group = "dbx-admins"
    # workspace users aad group
    workspace_contributor_aad_group = "dbx-contributors"
}