<!--- Copyright Allo authors. All Rights Reserved. -->
<!--- SPDX-License-Identifier: Apache-2.0  -->

Allo: A Programming Model for Composable Accelerator Design
==============================================================================

* Website: [FCCM'24](https://www.fccm.org/call-for-demo-2024/)
* Time: May 6, 2024

Special-purpose hardware accelerators are increasingly pivotal for sustaining performance improvements in emerging applications, especially as the benefits of technology scaling continue to diminish. However, designers currently lack effective tools and methodologies to construct complex, high-performance accelerator architectures in a productive manner. Existing high-level synthesis (HLS) tools often require intrusive source-level changes to attain satisfactory quality of results. Despite the introduction of several new accelerator design languages (ADL) aiming to enhance or replace HLS, their advantages are more evident in relatively simple applications with a single kernel. Existing ADLs prove less effective for realistic hierarchical designs with multiple kernels, even if the design hierarchy is flattened.

In this FCCM’24 demo, we present Allo, a composable programming model for efficient spatial accelerator design, recently accepted to PLDI’24. Allo decouples hardware customizations, including compute, memory, communication, and data type from algorithm specification, and encapsulates them as a set of customization primitives. Allo preserves the hierarchical structure of an input program by combining customizations from different functions in a bottom-up, type-safe manner. This approach facilitates holistic optimizations that span across function boundaries.

Specifically, we will showcase Allo's key features and highlight high-performance accelerators designed using Allo:
1. Implementing Allo kernels in an interactive notebook to demonstrate the idea of algorithm and customization decoupling, and transforming a GEMM kernel into a high-performance systolic array.
2. Utilizing Allo for single-kernel customizations on PolyBench applications, a widely-used C-based kernel library for benchmarking.
3. Leveraging Allo to conduct multi-kernel customizations for neural networks, showing direct import of PyTorch models to generate corresponding hardware accelerators.
4. Designing large-scale accelerators for large language models (LLMs) with Allo, which implements the spatial architecture in our FCCM’24 journal track paper “Understanding the Potential of FPGA-Based Spatial Acceleration for Large Language Model Inference”.
