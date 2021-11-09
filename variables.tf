# General variables
variable "Project" {
    type        = string
    default     = "itg" #User required to change for each project
    description = "Sapiens project name (<XXX>ccss-uat-db)"
}

variable "Customer" {
    type        = string
    default     = "cellcom" #User required to change for each project
    description = "4 chars shortcut for the customer/subscription name "
}

variable "Env" {
    type        = string
    default     = "prod" #User required to change for each project
    description = "prod / test / uat "
}

variable "Location" {
    type        = string
    default     = "East US" #User required to change for each project
    description = "location for all resources"
}


# Vnet variables


variable "cidr_address_space" {
    type        = string
    default     = "172.11.0.0/16" #User required to change for each project
    description = "cidr address space for vnet01"
}

variable "aks_sub_cidr_address_space" {
    type        = string
    default     = "172.11.0.0/20" #User required to change for each project
    description = "cidr address space for ask vnet"
 
}

variable "spoke_sub_cidr_address_space" {
    type        = string
    default     = "172.11.16.0/24" #User required to change for each project
    description = "cidr address space for ask vnet"
 
}

variable "pe_sub_cidr_address_space" {
    type        = string
    default     = "172.11.17.0/24" #User required to change for each project
    description = "cidr address space for ask vnet"
 
}
variable "lb_sub_cidr_address_space" {
    type        = string
    default     = "172.11.18.0/23" #User required to change for each project
    description = "cidr address space for ask vnet"
 }
variable "aks_subnet" {
    type        = string
    default     = ""
    
}
 variable "admin_user" {
    type        = string
    default     = "ofer"

}
 variable "admin_pswd" {
    type        = string
    default     = "QWEasd112233"
}
 