
# azure aks cluster
resource "azurerm_kubernetes_cluster" "aks-azure" {
  name                = var.aks-name
  location            = azurerm_resource_group.aks-vpc.location
  resource_group_name = azurerm_resource_group.aks-vpc.name
  dns_prefix          = var.aks-name
  private_cluster_enabled = false
  
  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
  
  tags = {
    Environment = "test"
  }
}


#container registry
resource "azurerm_container_registry" "container-reg" {
  name                     = var.container_registry
  resource_group_name      = azurerm_resource_group.aks-vpc.name
  location                 = azurerm_resource_group.aks-vpc.location
  sku                      = "Premium"
  admin_enabled            = false
  network_rule_set = [ {
    default_action = "Allow"
    ip_rule = [ {
    action = "Allow"
    ip_range = "89.138.6.3/32"
  } ]
    virtual_network = [ {
    action = "Allow"
    subnet_id = azurerm_subnet.aks-subnet["b"].id
  } ]
  } ]
 
}

# private link for private registry
resource "azurerm_private_endpoint" "azure-reg-link" {
  name                = "reg-link"
  location            = azurerm_resource_group.aks-vpc.location
  resource_group_name = azurerm_resource_group.aks-vpc.name
  subnet_id           = azurerm_subnet.aks-subnet["b"].id

  private_service_connection {
    name                           = "example-privateserviceconnection"
    private_connection_resource_id = azurerm_container_registry.container-reg.id
    is_manual_connection           = false
    subresource_names = ["registry"]  
  }
}







