#!/bin/bash

# Restore the original Xilinx binutils-2.26 linker if needed
sudo cp /home/ubuntu/Xilinx/Vivado/2023.1/tps/lnx64/binutils-2.26/bin/ld.original /home/ubuntu/Xilinx/Vivado/2023.1/tps/lnx64/binutils-2.26/bin/ld

echo "Original Xilinx binutils-2.26 linker has been restored." 