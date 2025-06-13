# Getting Started with HPC SMI DevOps

This guide will help you get started with the HPC SMI DevOps tools for managing NVIDIA and AMD GPUs.

## Prerequisites

Before you begin, ensure you have the following installed:

1. For NVIDIA GPUs:
   - NVIDIA drivers
   - CUDA toolkit
   - NVIDIA-SMI (comes with drivers)

2. For AMD GPUs:
   - AMD ROCm stack
   - ROCm-SMI (comes with ROCm)

3. General requirements:
   - Docker
   - Kubernetes (optional)
   - Terraform (optional)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/hpcsmi_ops.git
   cd hpcsmi_ops
   ```

2. Run the setup script:
   ```bash
   ./scripts/setup.sh
   ```

## Basic Usage

### Monitoring GPUs

#### NVIDIA GPUs
To monitor NVIDIA GPUs:
```bash
./scripts/nvidia/monitor_gpu.sh
```

For Prometheus metrics export:
```bash
./scripts/nvidia/monitor_gpu.sh --prometheus
```

#### AMD GPUs
To monitor AMD GPUs:
```bash
./scripts/amd/monitor_gpu.sh
```

For Prometheus metrics export:
```bash
./scripts/amd/monitor_gpu.sh --prometheus
```

## Advanced Usage

### Infrastructure as Code

The `terraform/` directory contains modules for deploying GPU clusters. See the specific module documentation for details.

### Kubernetes Integration

The `kubernetes/` directory contains manifests for deploying GPU workloads. See the specific manifest documentation for details.

### Docker Integration

The `docker/` directory contains Dockerfiles and configurations for GPU-enabled containers. See the specific Dockerfile documentation for details.

## Monitoring and Alerting

The `monitoring/` directory contains configurations for:
- Prometheus metrics collection
- Grafana dashboards
- Alert rules

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## Troubleshooting

### Common Issues

1. NVIDIA-SMI not found
   - Ensure NVIDIA drivers are properly installed
   - Check if the GPU is detected: `lspci | grep -i nvidia`

2. ROCm-SMI not found
   - Ensure ROCm stack is properly installed
   - Check if the GPU is detected: `lspci | grep -i amd`

3. Permission issues
   - Ensure you have the necessary permissions to access GPU devices
   - Check if you're in the correct groups (e.g., `video`, `render`)

## Support

For issues and feature requests, please create an issue in the GitHub repository. 