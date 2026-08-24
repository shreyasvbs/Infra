terraform {
  required_version = ">= 1.6.0"

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstateplatform123"
    container_name       = "tfstate"
    key                  = "platform-dev.tfstate"
    use_azuread_auth     = true
  }

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}