resource "azurerm_kubernetes_cluster" "aks-azure" {
  name                = var.aks-name
  location            = azurerm_resource_group.aks-vpc.location
  resource_group_name = azurerm_resource_group.aks-vpc.name
  dns_prefix          = var.aks-name
  private_cluster_enabled = false
  node_resource_group = var.ask_resource_name
  #network_profile     {
  #  network_plugin    = "azure"
  #  network_policy    = "azure"
  #}
  
  default_node_pool {
    name       = var.node_system
    node_count = var.node_count
    vm_size    = "Standard_D2_v2"
    vnet_subnet_id = azurerm_subnet.aks-subnet["a"].id
    
  }

  identity {
    type = "SystemAssigned"
  }
  
  tags = {
    Environment = "test"
  }
}




#resource "azurerm_network_security_rule" "aks-sg-rule-out" {
#  name                        = "test123"
#  priority                    = 100
#  direction                   = "Outbound"
#  access                      = "Allow"
#  protocol                    = "Tcp"
#  source_port_range           = "*"
#  destination_port_range      = "*"
#  source_address_prefix       = "*"
#  destination_address_prefix  = "*"
#  resource_group_name         = azurerm_kubernetes_cluster.aks-azure.node_resource_group
#  network_security_group_name = data.azurerm_network_security_group.aks-sg.name

#  depends_on = [
#    azurerm_kubernetes_cluster.aks-azure
#  ]
#  lifecycle {
#    create_before_destroy = true
#  }
#}


#resource "azurerm_network_security_rule" "aks-sg-rule-in" {
#  name                        = "test123"
#  priority                    = 100
#  direction                   = "Inbound"
#  access                      = "Deny"
#  protocol                    = "Tcp"
#  source_port_range           = "*"
#  destination_port_range      = "*"
#  source_address_prefix       = "*"
#  destination_address_prefix  = "*"
#  resource_group_name         = azurerm_kubernetes_cluster.aks-azure.node_resource_group
#  network_security_group_name = data.azurerm_network_security_group.aks-sg.name
#  depends_on = [
#    azurerm_kubernetes_cluster.aks-azure
#  ]

#}







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







