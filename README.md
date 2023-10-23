# azure_terraform
Azure Terraform Examples

# Overview

This azure_terraform repo contains sets of Azure Terraform examples which can be run locally in VS Code or another IDE of choice.

# Example 1: account_scim_permissions

In order to use this __'account_scim_permissions'__ template you will need to fill out the parameters in 'locals.tf' Terraform script.  The __'account_sp_client_id'__ parameter is essentially an Azure service principal which has Databricks account level admin access.

If this 'bot' like service principal is used to provision the workspace initially it will already be added as an adminstrator to the workspace it created.  This is a _prerequisite_ before running the __'account_scim_permissions'__ Terraform scripts to setup the rest of the workspace permissions and access.

The 'account_scim_permissions' example sets up initial Databricks workspace permissions post Databricks workspace creation.  It adds an account level __'admin'__ and __'contributors'__ Azure Active Directory (AAD) groups into the local Databricks workspace groups.  There is also an account level Databricks workspace __'admin level service principal'__ which is used for all Databricks workspace automation activities.  

This account level workspace __'admin level service principal'__ is added to the __'admin'__ AAD account level group.  After the account level AAD __'admin'__ group is added to the workspace groups it gets assigned to 'ADMIN' permissions to the workspace.  After the account level AAD '__contributors__' group is added to the workspace groups it gets assigned 'USER' permissions to the workspace.

The __'contributors'__ AAD account level group is assigned 'Workspace access' and 'Databricks SQL access' entitlements.  The __'admin'__ AAD account level group is assigned 'Workspace access', 'Databricks SQL access', 'Allow unrestricted cluster creation' and 'allow-instance-pool-create' entitlements.  The account level workspace __'admin level service principal'__ is assigned 'Workspace access', 'Databricks SQL access', 'Allow unrestricted cluster creation' and 'allow-instance-pool-create' entitlements.


