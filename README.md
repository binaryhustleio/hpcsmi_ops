# HPC SMI DevOps Portfolio

This repository showcases DevOps practices and tools for managing High Performance Computing (HPC) systems with NVIDIA and AMD GPUs using their respective System Management Interfaces (SMI).

## Overview

This portfolio demonstrates:
- GPU monitoring and management using NVIDIA-SMI and ROCm-SMI
- Automated deployment and configuration of GPU clusters
- Performance monitoring and optimization
- Infrastructure as Code (IaC) implementations
- Containerization strategies for GPU workloads
- CI/CD pipelines for GPU applications

## Repository Structure

```
.
├── docs/                    # Documentation and guides
├── scripts/                 # Utility scripts for GPU management
│   ├── nvidia/             # NVIDIA-specific scripts
│   └── amd/                # AMD-specific scripts
├── terraform/              # Infrastructure as Code
├── kubernetes/             # K8s manifests for GPU workloads
├── docker/                 # Docker configurations
└── monitoring/             # Monitoring and alerting configurations
```

## Prerequisites

- NVIDIA GPUs with CUDA support
- AMD GPUs with ROCm support
- NVIDIA-SMI (comes with NVIDIA drivers)
- ROCm-SMI (comes with AMD ROCm stack)
- Docker
- Kubernetes (optional)
- Terraform (optional)

## Getting Started

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/hpcsmi_ops.git
   cd hpcsmi_ops
   ```

2. Install required dependencies:
   ```bash
   ./scripts/setup.sh
   ```

3. Follow the guides in the `docs/` directory for specific use cases.

## Features

### NVIDIA GPU Management
- Automated driver installation and updates
- GPU monitoring and metrics collection
- Performance optimization scripts
- Container runtime configuration

### AMD GPU Management
- ROCm stack deployment automation
- GPU monitoring and metrics collection
- Performance optimization scripts
- Container runtime configuration

### Infrastructure as Code
- Terraform modules for GPU cluster deployment
- Ansible playbooks for configuration management
- Kubernetes manifests for GPU workloads

### Monitoring and Alerting
- Prometheus metrics collection
- Grafana dashboards
- Alert rules for GPU health and performance

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 