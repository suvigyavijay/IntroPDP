# 2D Filter in OMP

## Overview

This project implements and analyzes an efficient OMP (OpenMP) program for the fast application of 2D filters. The goal is to optimize the implementation of 2D filters, which are commonly used in image and signal processing. The project involves implementing a C++/OMP code for a 2D filter and analyzing its performance, scalability, and efficiency.

## Assignment Details

### Task

The task involves two main parts:

1. **A1Q1**: Implement a 2D filter in C++/OMP by editing the provided `a1.hpp` file. The `filter_2d` function needs to be extended to efficiently apply a 2D filter to a given matrix.

2. **A1Q2**: Analyze the performance of the implemented code. Benchmark the code, assess its scalability, and generate a speedup plot. Provide a detailed analysis and discussion of the findings.

### Problem Description

In this assignment, the objective is to develop an efficient OpenMP (OMP) program for the rapid application of 2D filters. 2D filters play a crucial role in image and signal processing applications, making the optimization of their implementations highly desirable.

Consider an image represented by a matrix $A$ with dimensions $n \times m$, where $n$ is the number of rows and $m$ is the number of columns. The kernel, denoted as $K$, is a square matrix, and for simplicity, it is assumed to be of size $3 \times 3$ throughout this assignment.

In the conventional 2D filtering process with kernel $K$, each pixel $A_{ij}$ undergoes convolution with the submatrix of $A$ centered at $A_{ij}$. This operation can be visualized as applying a stencil pattern.

However, this assignment introduces a modified version of the problem. Let $A_{i-1:i+1,j-1:j+1}$ represent the $3 \times 3$ submatrix of $A$ centered at coordinates $(i,j)$. The filter operation is defined as follows: 

1. Compute $Z = A_{i-1:i+1,j-1:j+1} \times K$, where $\times$ denotes the matrix product.
2. Obtain the filtered value $A'_{ij} = \sum_{a,b} Z_{ab}$. In other words, sum up all elements of the resulting matrix $Z$.
   
It is crucial to note that the filter is not applied to the first and the last row/column of $A$. Therefore, $A'_{ij} = A_{ij}$ if $i$ refers to the first/last row or $j$ refers to the first/last column.

The challenge lies in devising an optimized parallelized algorithm using OpenMP for this modified 2D filtering process, considering efficient memory usage, work distribution, and in-place computation for enhanced performance.

### Guidelines

1. **Download Project Backbone:**
   - Download the project backbone, which contains the initial structure of the project.

2. **Implementing `filter_2d` (A1Q1):**
   - Edit the `a1.hpp` file to implement or extend the `filter_2d` function.
   - The function takes four arguments:
     - $n$: Number of rows in matrix $A$.
     - $m$: Number of columns in matrix $A$.
     - $K$: Matrix $K$ stored row-wise as a vector.
     - $A$: Matrix $A$ stored row-wise as a vector. Note that $A$ serves as both the input and output destination.
   - **Constraints:**
     - **No Change in Signature:** Do not change the signature of the `filter_2d` function.
     - **No Editing of `a1.cpp`:** Do not edit the `a1.cpp` file as it serves as an example and will be used for testing.
     - **Memory Usage:** Pay attention to memory usage and perform as much work as possible in-place.

3. **Makefile Editing:**
   - The project provides a simple `Makefile`.
   - Edit the `Makefile` as needed to ensure the use of the proper compiler and flags for the project.
   - Ensure that, when invoked without arguments, the `Makefile` produces a production-quality executable named `a1` from `a1.cpp`.

4. **Benchmarking and Performance Assessment (A1Q2):**
   - Benchmark the resulting code to assess its performance on a CCR compute node.
   - When `a1` is invoked correctly, it prints to the standard output a single number, which is the runtime of `filter_2d` reported in seconds.
   - **Speedup Plot:**
     - Plot a relative speedup computed with respect to the runtime obtained with $p=1$ threads (denoted as $T_1$).
     - Report speedup on at least ten cores, with $p$ set in increments of two or a power of two (e.g., $p=[2,4,6,8,10]$).
   - **SLURM Job and Script:**
     - All measurements should be obtained within a single SLURM job.
     - The SLURM script should use a for loop to set the desired `OMP_NUM_THREADS` (or `taskset`) and call the `a1` code.
     - Include `#SBATCH --constraint=` in the script to uniquely identify the type of compute node used in the experiments.
     - Use `#SBATCH --output=%j.stdout` in the SLURM script to generate a unique file with the output from the job.

## Project Structure

The project structure includes the following files:

- **[`a1.hpp`](A1Q1/a1.hpp):** Header file containing the implementation of the `filter_2d` function.
- **[`a1.cpp`](A1Q1/a1.cpp):** Example instance of the engine testing the code.
- **[`Makefile`](A1Q1/Makefile):** Simple makefile for building the executable `a1`.
- **[`slurm.sh`](A1Q2/slurm.sh):** SLURM script used for benchmarking in A1Q2.
- **[`run.stdout`](A1Q2/run.stdout):** Output from running the SLURM script.
- **[`A1Q2.md`](A1Q2/A1Q2.md):** Markdown document containing the speedup plot, analysis, and discussion for A1Q2.

## Results

The results include the implementation of an efficient 2D filter in C++/OMP and an in-depth analysis of its performance. The speedup plot and discussion provide insights into the scalability and efficiency of the code.

## License

[All Rights Reserved License](../LICENSE).
