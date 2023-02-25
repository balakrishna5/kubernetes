terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "bkresourcegroup"
        storage_account_name = "bk9storageaccount"
        container_name       = "bk9container"
        key                  = "terraform.tfstate"
    }

}

provider "azurerm" {
  features {}
}