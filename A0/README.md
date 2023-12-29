
# Benchmarking a Parallel System

## Overview

This project focuses on benchmarking parallel systems, specifically by assessing the scalability and performance of a parallel algorithm implemented in C++. The assignment involves designing experiments, collecting data, and interpreting the results to understand the behavior of the parallel system.

## Assignment Details

### Task

- Benchmark a parallel algorithm provided in the [a0.cpp](a0.cpp) file.
- Choose a parallel computer (e.g., laptop, desktop, or a node in the CCR cluster) for testing.
- Assess the performance of the code on the chosen hardware.

### Problem Description

The assignment begins with an introduction to benchmarking parallel systems and emphasizes the importance of assessing scalability and performance after implementing a parallel algorithm. The provided C++ code, contained in the archive, implements a trivial parallel algorithm.

### Guidelines

1. **Compilation:** Use a C++20 compiler with OpenMP support, preferably GNU `g++`. A provided makefile can automate the compilation process.

2. **Runtime Measurement:** The code is equipped to report runtime in seconds. Edit the code to call the correct function for measurement.

3. **Parallel Function Invocation:** Adjust the number of threads/cores using the following command:

    ```bash
    OMP_NUM_THREADS=p ./a0 your_parameters
    ```

    Replace `p` with the desired number of threads/cores.

4. **Experiment Design:**
   - Choose between strong or weak scaling.
   - Consider the memory requirements of the code and system's main memory.
   - Ensure measurements are reliable by accounting for system jitter.
   - Plan experiments to yield useful data for interpreting results.

5. **Data Analysis:**
   - Benchmark by changing the number of processors (cores) following powers of two.
   - Tabulate runtime data and plot speedup and efficiency.
   - Report hardware and software details for result reproducibility.

## Project Structure

- **[`a0.cpp`](a0.cpp):** Archive containing the C++ code for benchmarking.
- **[`Makefile`](Makefile):** Automation script for compiling the code.
- **[`schedule.py`](schedule.py):** Python script for generating Slurm batch jobs.
- **[`slurm.sh`](test.sh):** Slurm batch job for running the code.
- **[`run.stdout`](run.stdout):** Output from running the slurm job.
- **[`analyze.py`](analyze.py):** Python script for parsing the generated output.
- **[`A0.md`](A0.md):** Report file summarizing the experiment, analysis, and results.

## Results

The project results are summarized in the [`A0.md`](A0.md) report, showcasing the scalability and performance analysis of the parallel algorithm.

## License

[All Rights Reserved License](../LICENSE).
