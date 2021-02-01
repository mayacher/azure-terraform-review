output "reg_privat_ip" {
  value = module.aks-azure-vpc.reg_privat_ip
}

output "k8s_client_certificate" {
  value = module.aks-azure-vpc.client_certificate 
}

output "k8s_kube_config" {
  value =  module.aks-azure-vpc.kube_config
}