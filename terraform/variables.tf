variable "azure_region" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "westus2"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "gpu-cluster-rg"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "gpu-cluster-vnet"
}

variable "vnet_cidr" {
  description = "CIDR block for virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "gpu-cluster"
}

variable "node_pool_name" {
  description = "Name of the node pool"
  type        = string
  default     = "gpunodepool"
}

variable "gpu_vm_size" {
  description = "Azure GPU VM size"
  type        = string
  default     = "Standard_NC6s_v3"  # NVIDIA T4 GPU
}

variable "node_count" {
  description = "Number of nodes in the cluster"
  type        = number
  default     = 2
}

variable "min_nodes" {
  description = "Minimum number of nodes"
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "Maximum number of nodes"
  type        = number
  default     = 5
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.24"
} 