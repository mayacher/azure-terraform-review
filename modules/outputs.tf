output "reg_privat_ip" {
  value = azurerm_private_endpoint.azure-reg-link.private_service_connection
}


output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks-azure.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks-azure.kube_config_raw
}
