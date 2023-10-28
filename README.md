# azure_terraform
Azure Terraform Examples

# Overview

This azure_terraform repo contains sets of Azure Terraform examples which can be run locally in VS Code or another IDE of choice.

# Example 1: account_scim_permissions

In order to use this __'account_scim_permissions'__ template you will need to fill out the parameters in 'locals.tf' Terraform script.  The __'account_sp_client_id'__ parameter is essentially an Azure service principal which has permissions to be able to create a Databricks workspace.

If this 'bot' like service principal is used to provision the workspace initially it will already be added as an adminstrator to the workspace it created.  This is a _prerequisite_ before running the __'account_scim_permissions'__ Terraform scripts to setup the rest of the workspace permissions and access.  

The 'account_scim_permissions' example sets up initial Databricks workspace permissions post Databricks workspace creation.  With the integration of account level SCIM all the AAD groups and users or a subset of groups and users will already be available in the Databricks account.  These groups and users can be assigned to a workspace by a workspace administrator (e.g. service principal) post workspace creation.

The 'account_scim_permissions' Terraform template adds the account level __'admin'__ and __'contributors'__ Azure Active Directory (AAD) groups into the local Databricks workspace groups.  There is also an account level Databricks workspace __'admin level service principal'__ which is used for all Databricks workspace automation activities.  

This account level workspace __'admin level service principal'__ is added to the __'admin'__ AAD account level group.  After the __'admin'__ AAD account level group is added to the workspace groups it gets assigned to 'ADMIN' permissions to the workspace.  This adds the __'admin'__ AAD account level group to the workspace system 'admins' group.  After the '__contributors__' AAD account level group is added to the workspace groups it gets assigned 'USER' permissions to the workspace.  This adds the __'contributors'__ AAD account level group to the workspace system 'users' group.

The account level workspace __'contributors'__ AAD group is assigned 'Workspace access' and 'Databricks SQL access' entitlements.  The account level workspace __'admin'__ AAD group is assigned 'Workspace access', 'Databricks SQL access', 'Allow unrestricted cluster creation' and 'allow-instance-pool-create' entitlements.  The account level workspace __'admin level service principal'__ is assigned 'Workspace access', 'Databricks SQL access', 'Allow unrestricted cluster creation' and 'allow-instance-pool-create' entitlements.

# Example 2: workspace_scim_permissions

In order to use this __'workspace_scim_permissions'__ template you will need to fill out the parameters in 'locals.tf' Terraform script.  The __'account_sp_client_id'__ parameter is essentially an Azure service principal which has permissions to be able to create a Databricks workspace.

If this 'bot' like service principal is used to provision the workspace initially it will already be added as an adminstrator to the workspace it created.  This is a _prerequisite_ before running the __'workspace_scim_permissions'__ Terraform scripts to setup the rest of the workspace permissions and access.

The 'workspace_scim_permissions' example sets up initial Databricks workspace permissions post Databricks workspace creation.  With the integration of workspace level SCIM _post workspace creation_ all the AAD groups and users or a subset of groups and users will already be available in the Databricks workspace.  At this point it is only necessary to ensure the __'admin'__ and __'contributors'__ Azure Active Directory (AAD) groups have the correct entitlements assigned.

There is also a Databricks workspace __'admin level service principal'__ which is used for all Databricks workspace automation activities.  The workspace __'admin level service principal'__ is added to the __'admin'__ AAD workspace level group, and the __'admins'__ workspace system group to ensure this service principal is a workspace administrator.

The __'contributors'__ AAD workspace level group is assigned 'Workspace access' and 'Databricks SQL access' entitlements.  The __'admin'__ AAD workspace level group is assigned 'Workspace access', 'Databricks SQL access', 'Allow unrestricted cluster creation' and 'allow-instance-pool-create' entitlements.  The workspace level workspace __'admin level service principal'__ is assigned 'Workspace access', 'Databricks SQL access', 'Allow unrestricted cluster creation' and 'allow-instance-pool-create' entitlements.

