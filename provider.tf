terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.81.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.14.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  # Do not set use_azure_cli or any SP-specific auth here; rely on environment variables in CI/CD, and az login locally.
}

provider "databricks" {
  azure_client_id              = var.spn_application_id
  azure_tenant_id              = var.tenant_id
  azure_workspace_resource_id  = var.databricks_workspace_resource_id
  host                        = var.databricks_host
}
