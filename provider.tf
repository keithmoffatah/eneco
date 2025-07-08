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
}

provider "databricks" {
  host = module.databricks_workspace.workspace_url
}
