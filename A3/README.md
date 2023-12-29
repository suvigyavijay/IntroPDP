# Gaussian Kernel in NVIDIA CUDA

## Overview

This project focuses on implementing an efficient NVIDIA CUDA program for fast computing of Gaussian kernel density estimates. The Gaussian Kernel Density Estimation is a widely used technique in machine learning and statistics for estimating the probability density function of a random variable.

## Assignment Details

### Task

The main task in this assignment is to implement the CUDA program for computing Gaussian kernel density estimates. The assignment is divided into two questions:

1. **A3Q1**: Implement the Gaussian kernel density estimator function.
2. **A3Q2**: Benchmark the resulting code on a CUDA capable GPGPU and provide an analysis of the performance.

## Problem Description

In this assignment, the objective is to implement an efficient NVIDIA CUDA program for the rapid computation of Gaussian kernel density estimates. Kernel Density Estimation (KDE) is a widely utilized technique in the fields of machine learning and statistics. It is employed to estimate the probability density function of a random variable.

### Kernel Density Estimation Formula

Given a sample vector $X=(x_1,x_2,\ldots,x_n)$ drawn from some univariate distribution with an unknown density function $f$, the KDE estimate $\hat{f}_h(x)$ is computed as follows:

$$
\hat{f}_h(x) = \frac{1}{n \cdot h}\sum_{i=1}^{n}K\left(\frac{x−x_i}{h}\right)
$$

Here, $h$ represents the bandwidth, acting as a smoothing factor, and $K$ is the kernel function.

### Gaussian Kernel Density Estimate

In the specific case of Gaussian kernel density estimate, the kernel function $K(x)$ is defined as:

$$
K(x) = \frac{1}{\sqrt{2\pi}}\exp\left(-\frac{x^2}{2}\right)
$$

### Estimation Process

Given an input vector $X=(x_1,x_2,\ldots,x_n)$ and a predefined bandwidth $h$, the goal is to estimate the density over $X$, resulting in an output vector $Y=(y_1,y_2,\ldots,y_n)$, where $y_i=\hat{f}_h(x_i)$.

Therefore, the primary task in this assignment is to efficiently compute $Y$ given $X$ and $h$.

## Guidelines

1. **Download the Project Backbone:**
   - Begin by downloading the project backbone which contains the initial structure and files required.

2. **Implement Gaussian Kernel Density Estimator (A3Q1):**
   - Your main task is to answer question A3Q1 by implementing or extending the `gaussian_kde` function in the `a3.hpp` file.
   - You are allowed to include additional files and implement extra functionality as needed, but you must adhere to the given signature of the `gaussian_kde` function.
   - The arguments of the `gaussian_kde` function are:
      - `n`: Size of the input/output vector.
      - `h`: Kernel bandwidth `h`.
      - `x`: Input vector $X$.
      - `y`: Output vector $Y$.
   - When implementing `gaussian_kde`, assume that all arguments are correct, and there is no need to test them. $X$ and $Y$ are guaranteed to be single precision, and the size $n$ of $X$ (and $Y$) is such that it exceeds the capacity of a single CUDA thread block but is small enough to be processed by a single kernel invocation (e.g., with multiple blocks).

3. **Edit the Makefile:**
   - The project backbone includes a simple `Makefile`.
   - Edit the `Makefile` as needed for your project to ensure that `nvcc` (NVIDIA CUDA Compiler) is used when required.
   - When the `Makefile` is invoked without arguments, it must produce an executable named `a3` from the `a3.cpp` file.

4. **Benchmarking (A3Q2):**
   - To answer question A3Q2, benchmark your resulting code on a CUDA capable GPGPU.
   - When correctly invoked, the `a3` executable should print to the standard output only one number, which is the runtime of the `gaussian_kde` function reported in seconds.
   - In your report for A3Q2, focus on reporting the runtime, for example, as a function of the problem size.
   - It is common when benchmarking GPGPU code to compare the performance with an equivalent code running on a CPU. 


## Project Structure

The project structure includes the following files and directories:

- **[`a3.hpp`](A3Q1/a3.hpp):** Header file containing the implementation of the `gaussian_kde` function.
- **[`a3.cpp`](A3Q1/a3.cpp):** Example engine testing the code.
- **[`Makefile`](A3Q1/Makefile):** Simple Makefile for compilation.
- **[`slurm.sh`](A3Q2/slurm.sh):** SLURM script used for benchmarking in A3Q2.
- **[`run.stdout`](A3Q2/run.stdout):** Output from running the SLURM script.
- **[`A3Q2.md`](A3Q2/A3Q2.md):** Markdown document containing the runtime plot, analysis, and discussion for A3Q2.

## Results

The primary result is the implementation of the Gaussian kernel density estimator and the subsequent benchmarking on a CUDA capable GPGPU. The assignment emphasizes the importance of efficient computation for this statistical technique.

## License

[All Rights Reserved License](../LICENSE).
