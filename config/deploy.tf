# use backend tfstate files (created manually)
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-storagestate"
    storage_account_name = "mayadevopsstorage"
    container_name       = "terraformdemo"
    key                  = "terraform.tfstate"
  }
}



terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

# import from dir module (I had a bug with terraform which only worked with full path)
module "aks-azure-vpc" {
  source = "/home/mayushtudio/learning/terraform-azure/modules/"
  # infrastructure config
  region = "northeurope"
  rg_name = "aks-resources"
  subnets =  {
     "a" = "10.0.1.0/24"
     "b" = "10.0.2.0/24"
     }
  subnet_cidr = "10.0.0.0/16"
  # aks config
  aks-name = "aks-cluster-test"
  container_registry = "mcherdevopsreg"

}



