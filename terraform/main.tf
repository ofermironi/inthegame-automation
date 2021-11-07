#-------------------------------------------------------------------------#
#-------------------------------------------------------------------------#
#------------------------ US-MGS-NAPCIP-MPL-CCSS-UAT ---------------------#
#-------------------------------------------------------------------------#
#-------------------------------------------------------------------------#

provider "azurerm" {
#   version = "2.80.0
  features {}
}
# Modules
module "main_resource_group" {
    source              = "./Modules/ResourceGroup"
    resource_group_name = "${var.Project}-${var.Customer}-${var.Env}-rg"
    Location            = "${var.Location}"
}

module "main_vnet" {
    source                           = "./Modules/Vnet"
#    vnet_01_name                    = "${var.Project}-${var.Customer}-${var.Env}-spoke-vnet"
    aks_vnet_01_name                 = "${var.Project}-${var.Customer}-${var.Env}-aks-vnet"
    spoke_subnet                     = "${var.Project}-${var.Customer}-${var.Env}-3-spoke-subnet"
    aks_subnet_name                  = "${var.Project}-${var.Customer}-${var.Env}-3-aks-subnet"
    pe_subnet_name                   = "${var.Project}-${var.Customer}-${var.Env}-3-pe-subnet"

    Location                         = "${var.Location}"
#    cidr_address_space              = "${var.cidr_address_space}"
    aks_cidr_address_space           = "${var.cidr_address_space}"
    aks_subnet_cidr_address_space    = "${var.aks_sub_cidr_address_space}"
    spoke_subnet_cidr_address_space  = "${var.spoke_sub_cidr_address_space}"
    pe_subnet_cidr_address_space     = "${var.pe_sub_cidr_address_space}"
    lb_subnet_cidr_address_space     = "${var.lb_sub_cidr_address_space}"
    resource_group_name              = "${var.Project}-${var.Customer}-${var.Env}-rg"
#    nsg_name                        = "${var.Project}-${var.Customer}-${var.Env}-nsg"
    depends_on                       = [module.main_resource_group]
}



module "storageaccount1" {
    source              = "./Modules/StorageAccount"
    Location            = "${var.Location}"
    resource_group_name = "${var.Project}-${var.Customer}-${var.Env}-rg"
    st_name             = "admin${var.Customer}3${var.Env}"
    replication_type    = "LRS"      
    depends_on          = [module.main_resource_group]
}

module "storageaccount2" {
    source              = "./Modules/StorageAccount"
    Location            = "${var.Location}"
    resource_group_name = "${var.Project}-${var.Customer}-${var.Env}-rg"
    st_name             = "live${var.Customer}3${var.Env}" 
    replication_type    = "LRS"      
    depends_on          = [module.main_resource_group]
}

module "Aks1" {
    aks_name                = "${var.Project}-${var.Customer}-${var.Env}-3-aks" 
    aks_node_pool_vm_size   = "Standard_D4s_v3" #User required to change for each project (from azure size list)
    aks_os_disk_size_gb     = "128" #User required to change for each project
    node_count              = "1" #User required to change for each project
    aks_subnet              = "${var.Project}-${var.Customer}-${var.Env}-3-aks-subnet" #User required to change for each project (generally should be for AKS_subnet)
    aks_sub_id              =  module.main_vnet.aks-subnet-id
    source                  = "./Modules/Aks"
    aks_vnet_01_name        = "${var.Project}-${var.Customer}-${var.Env}-spoke-vnet"
    #acr_name                = "${var.Project}-${var.Customer}${var.Env}acr01"
    Location                = "${var.Location}"
    resource_group_name     = "${var.Project}-${var.Customer}-${var.Env}-rg"
#    depends_on              = [module.main_vnet, module.Acr, module.main_resource_group]
    depends_on              = [module.main_vnet, module.main_resource_group]
}

