terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
  backend "local" {
    path = "D:/__DEMOS/terraform.tfstate.d/rg/terraform.tfstate"
    workspace_dir = "D:/__DEMOS/terraform.tfstate.d/rg"
  }
}