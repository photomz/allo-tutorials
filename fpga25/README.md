<!--- Copyright Allo authors. All Rights Reserved. -->
<!--- SPDX-License-Identifier: Apache-2.0  -->

Python-Based Accelerator Design and Programming with Allo
==============================================================================

* Website: [FPGA'25 Tutorial](https://www.isfpga.org/workshops-tutorials/#t1)
* Time: March 1, 2025 | 09:00AM – 12:15PM
* Organizers: Hongzheng Chen (Cornell), Niansong Zhang (Cornell), Shaojie Xiang (Cornell), Zhiru Zhang (Cornell)

Special-purpose hardware accelerators are increasingly pivotal for sustaining performance improvements in emerging machine learning and scientific applications, especially as the benefits of technology scaling continue to diminish. However, designers currently lack effective tools and methodologies to construct complex, high-performance accelerator architectures in a productive manner. Existing high-level synthesis (HLS) tools often require intrusive source-level changes to attain satisfactory quality of results. Despite the introduction of several new accelerator design languages (ADLs) aiming to enhance or replace HLS, they prove less effective for realistic hierarchical designs with multiple kernels, even if the design hierarchy is flattened.

In this tutorial, we will present Allo, a Python-based composable programming model for efficient accelerator design. Allo decouples hardware customizations—such as compute, memory, communication, and data types—from algorithm specifications, encapsulating them into a set of customization primitives. By preserving the hierarchical structure of input programs, Allo integrates customizations across functions in a bottom-up, type-safe manner, enabling holistic optimizations that span function boundaries. Specifically, we will:

1. Demonstrate the concept of decoupling customizations from algorithms.
2. Utilize Allo to optimize both single-kernel and multi-kernel designs, with examples including PolyBench, convolutional neural networks (CNNs), and large language models (LLMs).
3. Discuss our latest advancements in spatial and temporal composition, and showcase the mapping flow to AMD Versal FPGAs and AMD Ryzen AIE hardware.

This tutorial is based on our publications in PLDI’24, FPGA’25, ’24, ’22, ’19, DAC’22, and FCCM’24. The Allo framework is open-source and available at https://github.com/cornell-zhang/allo.