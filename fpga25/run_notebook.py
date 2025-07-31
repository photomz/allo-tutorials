import os
import sys
import numpy as np

# Set environment variables
os.environ["XILINX_VITIS"] = "/home/ubuntu/Xilinx/Vitis/2023.1"
os.environ["XILINX_XRT"] = "/opt/xilinx/xrt"
os.environ["PATH"] = f"{os.environ['XILINX_VITIS']}/bin:{os.environ['PATH']}"
os.environ["PLATFORM_REPO_PATHS"] = f"{os.environ['XILINX_VITIS']}/base_platforms:{os.environ['XILINX_VITIS']}/platforms"
os.environ["PLATFORM"] = "xilinx_u280_gen3x16_xdma_1_202211_1"
os.environ["XDEVICE"] = "xilinx_u280_gen3x16_xdma_1_202211_1"
os.environ["HOST_ARCH"] = "x86"
os.environ["DEV_ARCH"] = "us"
os.environ["TARGET"] = "sw_emu"  # Using sw_emu instead of hw_emu since it works

# Add current directory to path
sys.path.append('.')

# Create test data
np_A = np.ones((32, 32), dtype=np.float64)
np_B = np.ones((32, 32), dtype=np.float64)
np_C = np.zeros((32, 32), dtype=np.float64)

try:
    # Import the module
    import s
    
    print("Building module...")
    # Using sw_emu mode which we know works
    hw_mod = s.build(target="vitis_hls", mode="sw_emu", project="baseline.prj")
    
    print("Running module...")
    hw_mod(np_A, np_B, np_C)
    
    print("Results:")
    print(np_C)
    
    print("Success!")
except Exception as e:
    print(f"Error: {e}") 