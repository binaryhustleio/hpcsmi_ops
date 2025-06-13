#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if rocm-smi is available
if ! command -v rocm-smi &> /dev/null; then
    echo -e "${RED}Error: rocm-smi is not installed${NC}"
    exit 1
fi

# Function to get GPU metrics
get_gpu_metrics() {
    local gpu_id=$1
    echo -e "${YELLOW}GPU $gpu_id Metrics:${NC}"
    
    # Get GPU utilization
    local utilization=$(rocm-smi --showuse --id $gpu_id | grep "GPU use" | awk '{print $3}')
    echo -e "GPU Utilization: ${GREEN}$utilization${NC}"
    
    # Get memory usage
    local memory_info=$(rocm-smi --showmeminfo --id $gpu_id | grep "Used Memory" | awk '{print $3, $4}')
    echo -e "Memory Usage: ${GREEN}$memory_info${NC}"
    
    # Get temperature
    local temperature=$(rocm-smi --showtemp --id $gpu_id | grep "GPU" | awk '{print $2}')
    echo -e "Temperature: ${GREEN}$temperature°C${NC}"
    
    # Get power usage
    local power_usage=$(rocm-smi --showpower --id $gpu_id | grep "Average Graphics Package Power" | awk '{print $5}')
    echo -e "Power Usage: ${GREEN}$power_usage W${NC}"
    
    echo "----------------------------------------"
}

# Get number of GPUs
num_gpus=$(rocm-smi --showcount | grep "GPU count" | awk '{print $3}')

echo -e "${GREEN}Monitoring $num_gpus AMD GPU(s)...${NC}"
echo "----------------------------------------"

# Monitor each GPU
for ((i=0; i<$num_gpus; i++)); do
    get_gpu_metrics $i
done

# Optional: Export metrics to Prometheus format
if [ "$1" == "--prometheus" ]; then
    echo "# HELP amd_gpu_utilization GPU utilization percentage"
    echo "# TYPE amd_gpu_utilization gauge"
    for ((i=0; i<$num_gpus; i++)); do
        utilization=$(rocm-smi --showuse --id $i | grep "GPU use" | awk '{print $3}' | sed 's/%//')
        echo "amd_gpu_utilization{gpu=\"$i\"} $utilization"
    done
fi 