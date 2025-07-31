#!/bin/bash

# Setup environment variables as in the notebook
export XILINX_VITIS=/home/ubuntu/Xilinx/Vitis/2023.1
export XILINX_XRT=/opt/xilinx/xrt
export PATH=$XILINX_VITIS/bin:$PATH
export PLATFORM_REPO_PATHS=$XILINX_VITIS/base_platforms:$XILINX_VITIS/platforms
export PLATFORM=xilinx_u280_gen3x16_xdma_1_202211_1
export XDEVICE=xilinx_u280_gen3x16_xdma_1_202211_1
export HOST_ARCH=x86
export DEV_ARCH=us
export TARGET=hw_emu
export LD_LIBRARY_PATH=/home/ubuntu/xilinx_compat_libs/lib:$LD_LIBRARY_PATH

cd /home/ubuntu/aloe/allo-tutorials/fpga25/baseline.prj

# Clean build
make clean

# First, build just the XO file without trying to link it
mkdir -p ./_x.hw_emu.xilinx_u280_gen3x16_xdma_1_202211_1
v++ -c -g --save-temps -t hw_emu --platform xilinx_u280_gen3x16_xdma_1_202211_1 -k gemm --temp_dir ./_x.hw_emu.xilinx_u280_gen3x16_xdma_1_202211_1 -I. -o _x.hw_emu.xilinx_u280_gen3x16_xdma_1_202211_1/gemm.xo kernel.cpp

# Find the directory with the libdpi.so issue
mkdir -p ./build_dir.hw_emu.xilinx_u280_gen3x16_xdma_1_202211_1

# Start the link phase but it will fail at the libdpi.so creation
v++ -l -g --save-temps -t hw_emu --platform xilinx_u280_gen3x16_xdma_1_202211_1 --temp_dir ./_x.hw_emu.xilinx_u280_gen3x16_xdma_1_202211_1 --optimize 3 --kernel_frequency 300 -o./build_dir.hw_emu.xilinx_u280_gen3x16_xdma_1_202211_1/gemm.link.xclbin _x.hw_emu.xilinx_u280_gen3x16_xdma_1_202211_1/gemm.xo || true

XSIM_DIR=$(find _x.hw_emu.* -path "*behav_waveform/xsim" -type d | head -1)

if [ -n "$XSIM_DIR" ]; then
  echo "Found XSIM directory: $XSIM_DIR"
  cd $XSIM_DIR
  
  # Clean up any existing files first
  rm -f libdpi.so
  
  echo "Manually building libdpi.so..."
  # Use the system GCC instead
  g++ -Wa,-W -O -fPIC -m64 -shared \
    -o "libdpi.so" xsim.dir/xil_defaultlib/xsc/*.o \
    -L/home/ubuntu/Xilinx/Vivado/2023.1/data/simmodels/xsim/2023.1/lnx64/9.3.0/ext/protobuf -lprotobuf \
    -L/home/ubuntu/Xilinx/Vivado/2023.1/lib/lnx64.o -lrdi_simulator_kernel \
    -lstdc++ -lm -lgcc_s -lc -lgcc_s
    
  if [ $? -eq 0 ]; then
    echo "Successfully built libdpi.so"
    ls -la libdpi.so
    
    # Find the XSIM directory in full path
    XSIM_FULL_PATH=$(pwd)
    echo "XSIM full path: $XSIM_FULL_PATH"
    
    # Return to project directory
    cd /home/ubuntu/aloe/allo-tutorials/fpga25/baseline.prj
    
    # Now continue with the build from where it left off
    echo "Running emulation..."
    cd ../
    
    # Use the hw_mod function from the notebook directly
    python -c "
import os
import sys
sys.path.append('.')
import numpy as np

# Create sample data
np_A = np.ones((32, 32), dtype=np.float64)
np_B = np.ones((32, 32), dtype=np.float64)
np_C = np.zeros((32, 32), dtype=np.float64)

import s
hw_mod = s.build(target='vitis_hls', mode='hw_emu', project='baseline.prj')
print('Build successful, running module...')
hw_mod(np_A, np_B, np_C)
print('Execution complete')
"
  else
    echo "Failed to build libdpi.so"
    exit 1
  fi
else
  echo "Could not find XSIM directory"
  exit 1
fi 