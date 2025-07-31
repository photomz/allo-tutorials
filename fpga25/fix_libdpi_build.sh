#!/bin/bash

# Hardware emulation is failing in the libdpi.so build step due to missing crti.o
# We need to override the compiler search paths to include the system libraries

# Save current directory
CURR_DIR=$(pwd)

# Set the environment for the Xilinx compiler
export XILINX_VIVADO=/home/ubuntu/Xilinx/Vivado/2023.1
export XILINX_GCC_PATH=$XILINX_VIVADO/tps/lnx64/gcc-9.3.0
export GCC_LIB_PATH=$XILINX_GCC_PATH/lib64

# Run the hardware emulation build
cd baseline.prj
make TARGET=hw_emu PLATFORM=xilinx_u280_gen3x16_xdma_1_202211_1 | tee build_hw_emu.log 

# If libdpi.so error occurs, find the build directory and fix it
if grep -q "libdpi.so.*failed" build_hw_emu.log; then
  echo "Detected libdpi.so build failure, attempting to fix..."
  
  # Find the XSIM directory
  XSIM_DIR=$(find _x.hw_emu.* -path "*behav_waveform/xsim" -type d | head -1)
  
  if [ -n "$XSIM_DIR" ]; then
    echo "Found XSIM directory: $XSIM_DIR"
    cd $XSIM_DIR
    
    # Copy system libraries
    cp /usr/lib/x86_64-linux-gnu/crti.o .
    cp /usr/lib/x86_64-linux-gnu/crtn.o .
    
    # Compile libdpi.so manually with correct paths
    echo "Manually building libdpi.so..."
    /home/ubuntu/Xilinx/Vivado/2023.1/tps/lnx64/gcc-9.3.0/bin/g++ -Wa,-W -O -fPIC -m64 -shared \
      -o "libdpi.so" ./crti.o xsim.dir/xil_defaultlib/xsc/*.o ./crtn.o \
      -L/home/ubuntu/Xilinx/Vivado/2023.1/data/simmodels/xsim/2023.1/lnx64/9.3.0/ext/protobuf -lprotobuf \
      -L/home/ubuntu/Xilinx/Vivado/2023.1/lib/lnx64.o -lrdi_simulator_kernel \
      -L/usr/lib/x86_64-linux-gnu -L/lib/x86_64-linux-gnu \
      -Wl,-rpath=/home/ubuntu/Xilinx/Vivado/2023.1/lib/lnx64.o/../../tps/lnx64/gcc-9.3.0/lib64 \
      -lstdc++ -lm -lgcc_s -lc -lgcc_s
    
    cd - > /dev/null
    
    # Continue with the build
    echo "Continuing build process..."
    make TARGET=hw_emu PLATFORM=xilinx_u280_gen3x16_xdma_1_202211_1
  else
    echo "Could not find XSIM directory"
  fi
fi

# Return to original directory
cd $CURR_DIR 