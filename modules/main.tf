terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}



provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks-vpc" {
  name     = var.rg_name
  location = var.region
}



resource "azurerm_virtual_network" "aks-vpc" {
  name          = "${var.rg_name}-net"
  address_space = [var.subnet_cidr]
  resource_group_name  = azurerm_resource_group.aks-vpc.name
  location      = azurerm_resource_group.aks-vpc.location

}  


resource "azurerm_subnet" "aks-subnet" {
  for_each = var.subnets
  name = "subnet-${each.key}"
  resource_group_name = azurerm_resource_group.aks-vpc.name
  virtual_network_name = azurerm_virtual_network.aks-vpc.name
  address_prefixes = [each.value]
  enforce_private_link_endpoint_network_policies = (each.key == "b" ?  true : false)
  service_endpoints =  (each.key == "b" ? [ "Microsoft.ContainerRegistry" ] : null)

}
