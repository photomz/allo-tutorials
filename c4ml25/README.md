<!--- Copyright Allo authors. All Rights Reserved. -->
<!--- SPDX-License-Identifier: Apache-2.0  -->

Allo: Catalyzing Accelerator Design and Programming for Machine Learning
==============================================================================

* Website: [C4ML workshop @ CGO'25](https://www.c4ml.org/c4ml-2025)
* Time: March 2, 2025 | 14:20 – 15:00 PT

As the benefits of technology scaling diminish, specialized hardware accelerators are crucial for performance in emerging machine learning applications. However, designers currently lack effective tools and methodologies to construct complex, high-performance accelerator architectures. Existing high-level synthesis (HLS) tools often require intrusive source-level changes to attain satisfactory quality of results. While new accelerator design languages (ADLs) aim to enhance or replace HLS, they are typically more effective for simple applications with a single kernel, rather than for hierarchical designs with multiple kernels.

In the first part of this talk, we will introduce Allo, a composable programming model for efficient hardware accelerator design. Allo decouples hardware customizations, including compute, memory, communication, and data types from algorithm specification, and encapsulates them as a set of customization primitives, which enables verifiable stepwise optimizations. Allo also preserves the hierarchical structure of an input program by combining customizations from different functions in a bottom-up, type-safe manner, enabling both temporal and spatial composition.

We will then illustrate how Allo optimizes large-scale designs with two case studies. First, we develop a spatial accelerator architecture for large language models (LLMs) and prototype it on an AMD U280 FPGA, demonstrating higher energy efficiency than NVIDIA GPUs in generative inference settings. In addition, we deploy a convolutional neural network (CNN) design using Allo on the AMD Ryzen AI Engine, achieving substantial speedups over prior approaches.