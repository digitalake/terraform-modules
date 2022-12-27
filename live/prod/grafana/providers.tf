# Defining provedires for project
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.46.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Defining aws provider details
provider "aws" {
}

# Difining azure provider details
provider "azurerm" {
  features {}
}