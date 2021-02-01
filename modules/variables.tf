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
variable "container_registry" {
  
}