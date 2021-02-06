
data "azurerm_network_security_group" "aks-sg" {
  resource_group_name = azurerm_kubernetes_cluster.aks-azure.node_resource_group
  name = "aks-agentpool-22784237-nsg"

  depends_on = [
    azurerm_kubernetes_cluster.aks-azure
  ]
}