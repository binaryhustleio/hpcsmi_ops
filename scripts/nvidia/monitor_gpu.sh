#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if nvidia-smi is available
if ! command -v nvidia-smi &> /dev/null; then
    echo -e "${RED}Error: nvidia-smi is not installed${NC}"
    exit 1
fi

# Function to get GPU metrics
get_gpu_metrics() {
    local gpu_id=$1
    echo -e "${YELLOW}GPU $gpu_id Metrics:${NC}"
    
    # Get GPU utilization
    local utilization=$(nvidia-smi -i $gpu_id --query-gpu=utilization.gpu --format=csv,noheader,nounits)
    echo -e "GPU Utilization: ${GREEN}$utilization%${NC}"
    
    # Get memory usage
    local memory_used=$(nvidia-smi -i $gpu_id --query-gpu=memory.used --format=csv,noheader,nounits)
    local memory_total=$(nvidia-smi -i $gpu_id --query-gpu=memory.total --format=csv,noheader,nounits)
    echo -e "Memory Usage: ${GREEN}$memory_used MB / $memory_total MB${NC}"
    
    # Get temperature
    local temperature=$(nvidia-smi -i $gpu_id --query-gpu=temperature.gpu --format=csv,noheader,nounits)
    echo -e "Temperature: ${GREEN}$temperature°C${NC}"
    
    # Get power usage
    local power_usage=$(nvidia-smi -i $gpu_id --query-gpu=power.draw --format=csv,noheader,nounits)
    echo -e "Power Usage: ${GREEN}$power_usage W${NC}"
    
    echo "----------------------------------------"
}

# Get number of GPUs
num_gpus=$(nvidia-smi --query-gpu=count --format=csv,noheader,nounits)

echo -e "${GREEN}Monitoring $num_gpus NVIDIA GPU(s)...${NC}"
echo "----------------------------------------"

# Monitor each GPU
for ((i=0; i<$num_gpus; i++)); do
    get_gpu_metrics $i
done

# Optional: Export metrics to Prometheus format
if [ "$1" == "--prometheus" ]; then
    echo "# HELP nvidia_gpu_utilization GPU utilization percentage"
    echo "# TYPE nvidia_gpu_utilization gauge"
    for ((i=0; i<$num_gpus; i++)); do
        utilization=$(nvidia-smi -i $i --query-gpu=utilization.gpu --format=csv,noheader,nounits)
        echo "nvidia_gpu_utilization{gpu=\"$i\"} $utilization"
    done
fi 