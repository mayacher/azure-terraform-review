variable region  {
    default = "northeurope"
}

# infra
variable rg_name  {
    type = string
}

variable subnet_cidr  {
    type = string
}

variable subnets {
   type = map
}


# aks

variable "aks-name" {
  
}

variable "node_count" {

}

variable "ask_resource_name" {

}

variable "node_system" {
    
}
variable "container_registry" {
  
}