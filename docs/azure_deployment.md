# Azure GPU Cluster Deployment Guide

This guide will help you deploy a GPU-enabled Kubernetes cluster on Azure using the provided Terraform configurations.

## Prerequisites

1. Azure CLI installed and configured
2. Terraform installed
3. kubectl installed
4. Azure subscription with GPU quota

## Initial Setup

1. Login to Azure:
   ```bash
   az login
   ```

2. Set your subscription:
   ```bash
   az account set --subscription <subscription-id>
   ```

3. Create a service principal for Terraform:
   ```bash
   az ad sp create-for-rbac --name "TerraformGPUCluster" --role contributor \
     --scopes /subscriptions/<subscription-id> --sdk-auth
   ```

4. Save the service principal credentials to `~/.azure/credentials.json`

## Deployment Steps

1. Initialize Terraform:
   ```bash
   cd terraform
   terraform init
   ```

2. Review the deployment plan:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

4. Get AKS credentials:
   ```bash
   az aks get-credentials --resource-group gpu-cluster-rg --name gpu-cluster
   ```

## GPU Node Pool Configuration

The deployment creates a GPU-enabled node pool using `Standard_NC6s_v3` VMs, which feature NVIDIA T4 GPUs. The node pool is configured with:

- Autoscaling enabled (1-5 nodes)
- NVIDIA GPU drivers pre-installed
- GPU device plugin configured

## Monitoring Setup

1. Deploy the monitoring stack:
   ```bash
   kubectl apply -f kubernetes/gpu-workload.yaml
   ```

2. Verify GPU nodes:
   ```bash
   kubectl get nodes -l kubernetes.azure.com/gpu-accelerator=nvidia-tesla-t4
   ```

3. Check GPU monitoring pods:
   ```bash
   kubectl get pods -n gpu-workloads
   ```

## Cost Considerations

- `Standard_NC6s_v3` VMs with NVIDIA T4 GPUs are billed per hour
- Consider using Azure Spot instances for non-production workloads
- Monitor resource usage to optimize costs

## Troubleshooting

### Common Issues

1. GPU nodes not showing up:
   ```bash
   az aks nodepool list --resource-group gpu-cluster-rg --cluster-name gpu-cluster
   ```

2. GPU drivers not working:
   ```bash
   kubectl logs -n kube-system -l app=nvidia-device-plugin-daemonset
   ```

3. Quota issues:
   ```bash
   az vm list-usage --location westus2 --output table
   ```

### Support

For Azure-specific issues:
- Azure Support Portal
- Azure GPU Documentation
- Azure AKS Documentation

## Cleanup

To remove all resources:
```bash
terraform destroy
``` 