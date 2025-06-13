#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up HPC SMI DevOps environment...${NC}"

# Function to check if a command exists
check_command() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}Error: $1 is not installed${NC}"
        return 1
    else
        echo -e "${GREEN}✓ $1 is installed${NC}"
        return 0
    fi
}

# Check for NVIDIA GPU and drivers
if lspci | grep -i nvidia &> /dev/null; then
    echo -e "${YELLOW}NVIDIA GPU detected${NC}"
    if check_command nvidia-smi; then
        NVIDIA_VERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader,nounits)
        echo -e "${GREEN}NVIDIA Driver version: $NVIDIA_VERSION${NC}"
    fi
fi

# Check for AMD GPU and ROCm
if lspci | grep -i amd &> /dev/null; then
    echo -e "${YELLOW}AMD GPU detected${NC}"
    if check_command rocm-smi; then
        AMD_VERSION=$(rocm-smi --version | head -n 1)
        echo -e "${GREEN}ROCm version: $AMD_VERSION${NC}"
    fi
fi

# Check for other dependencies
check_command docker
check_command kubectl
check_command terraform

# Create necessary directories if they don't exist
mkdir -p ~/.config/hpcsmi_ops
mkdir -p ~/.local/bin

# Make scripts executable
chmod +x scripts/nvidia/*.sh
chmod +x scripts/amd/*.sh

echo -e "${GREEN}Setup completed!${NC}"
echo -e "${YELLOW}Please check the docs/ directory for detailed usage instructions.${NC}" 