# Sorting Small Integers with MPI

## Overview

This project involves implementing and analyzing an efficient MPI program to sort small integers in distributed memory. The goal is to sort an array of small integers across multiple processors, avoiding large all-to-all data exchange. The project includes two questions: A2Q1, where the MPI sorting routine is implemented, and A2Q2, where the performance of the solution is analyzed.

## Assignment Details

### Task

The main task is to implement and analyze an MPI program for sorting small integers efficiently in a distributed memory environment. The assignment consists of two questions:

1. **A2Q1**: Implement the MPI sorting routine by editing `a2.hpp` and extending the `isort` function.
2. **A2Q2**: Benchmark the resulting code to assess its performance on CCR compute nodes, generate a speedup plot, and provide a brief discussion summarizing the findings.

### Problem Description

Your task is to sort an array of small integers distributed among multiple processors in a way that avoids large all-to-all data exchange. The small integer array is represented as $X = [x_0, x_1, \ldots, x_{n-1}]$, where each $x_i$ is a signed 16-bit integer, and $x_i \in [-(p-1), p-1]$. The sorting algorithm should guarantee that for any $x_i = x_j$, both keys will be assigned to the same processor. Each processor should be assigned some keys, and the keys assigned to processor $i$ should be less than or equal to the keys assigned to processor $j$ for $i < j$.

## Guidelines

1. **Download Project Backbone:**
   - Download files containing the project backbone.

2. **Code Implementation (A2Q1):**
   - Edit `a2.hpp` to answer question A2Q1.
   - Implement or extend the `isort` function.
   - You may include extra files and implement additional functionality as needed.
   - Do not change the signature of `isort`.
   - The `isort` function takes two arguments:
     - `Xi`: Input/output vector representing a part of the array $X$ on a given processor. At the beginning of the invocation, it stores input integers to be sorted, and at the end, it should store a part of the sorted $X$.
     - `comm`: MPI communicator used for all communication within `isort`.
   - Assume that all arguments are correct; no need to test them.

3. **Makefile and Compilation:**
   - The project backbone includes a simple `Makefile`.
   - Feel free to edit it to ensure the proper compiler and flags are used for your project.
   - Keep in mind that when invoked without arguments, the `Makefile` must produce a production-quality executable `a2` from `a2.cpp`.

4. **Performance Benchmarking (A2Q2):**
   - To answer question A2Q2, benchmark the resulting code.
   - Assess the performance on CCR compute nodes.
   - When invoked correctly, `a2` prints one number, the runtime of `isort` (reported in seconds).
   - Plot relative speedup computed with respect to runtime obtained on $p=2$ ranks (with respect to $T_2$).
   - Report speedup on at least $p=16$ ranks distributed on more than one physical node.
   - Plot speedup for at least two different values of $n$.
   - Choose $n$ such that the use of RAM memory by $X$ per rank is at least 4GB.
   - Add `#SBATCH --constraint=` to the script to clearly and uniquely identify the type of compute nodes used in the experiments.
   - Use `#SBATCH --output=%j.stdout` in the SLURM script to generate a unique file with the output from the job.


## Project Structure

The project structure includes the following files:

- **[`a2.hpp`](A2Q1/a2.hpp):** Header file containing the implementation of the `isort` function.
- **[`a2.cpp`](A2Q1/a2.cpp):** Example engine for testing the code.
- **[`Makefile`](A2Q1/Makefile):** Simple Makefile for compilation.
- **[`slurm.sh`](A2Q2/slurm.sh):** SLURM script used for benchmarking in A2Q2.
- **[`run.stdout`](A2Q2/run.stdout):** Output from running the SLURM script.
- **[`A2Q2.md`](A2Q2/A2Q2.md):** Markdown document containing the speedup plot, analysis, and discussion for A2Q2.

## Results

The project aims to achieve an efficient sorting algorithm for small integers using MPI. The performance analysis in A2Q2 involves benchmarking the code on compute nodes, generating speedup plots, and providing a thorough discussion of the findings.

## License

[All Rights Reserved License](../LICENSE).
