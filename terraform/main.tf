terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  location = var.azure_region
}

# Resource Group
resource "azurerm_resource_group" "gpu_cluster" {
  name     = var.resource_group_name
  location = var.azure_region
}

# Virtual Network
module "vnet" {
  source = "./modules/vnet"

  resource_group_name = azurerm_resource_group.gpu_cluster.name
  location           = var.azure_region
  vnet_name          = var.vnet_name
  vnet_cidr          = var.vnet_cidr
}

# AKS Cluster
module "aks" {
  source = "./modules/aks"

  resource_group_name = azurerm_resource_group.gpu_cluster.name
  location           = var.azure_region
  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  node_count         = var.node_count
  vm_size            = var.gpu_vm_size
  subnet_id          = module.vnet.subnet_id
}

# GPU Node Pool
module "gpu_node_pool" {
  source = "./modules/gpu_node_pool"

  resource_group_name = azurerm_resource_group.gpu_cluster.name
  cluster_name       = var.cluster_name
  node_pool_name     = var.node_pool_name
  vm_size            = var.gpu_vm_size
  node_count         = var.node_count
  min_count          = var.min_nodes
  max_count          = var.max_nodes
  subnet_id          = module.vnet.subnet_id
}

# GPU Operator
module "gpu_operator" {
  source = "./modules/gpu_operator"

  cluster_name = var.cluster_name
  depends_on   = [module.aks]
} 