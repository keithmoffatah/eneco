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
}

provider "databricks" {
  host  = module.databricks_workspace.workspace_url
  token = var.databricks_token
}
