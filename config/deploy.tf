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


module "aks-azure-vpc" {
  source = "/home/mayushtudio/learning/terraform-azure/modules/"
  # infrastructure config
  region = "northeurope"
  rg_name = "aks-resources"
  subnets =  {
     "a" = "172.22.1.0/24"
     "b" = "172.22.2.0/24"
     }
  subnet_cidr = "172.22.0.0/16"
  # aks config
  aks-name = "aks-cluster-test"
  ask_resource_name = "aks-mcdevops"
  node_count = 2
  node_system = "npoolsystem"
  container_registry = "mcherdevopsreg"

}



