# CSE 470|570 A0: Benchmarking a Parallel System

#### Due on: 10/02/2023, 11:59PM ET — Extended till 10/04/223

## Problem

The goal of this assignment is to get you started with benchmarking parallel systems. Remember, once you designed and implemented a parallel algorithm, and you are ready to deploy it on a specific parallel computer, you want to assess scalability/performance of the resulting system. This is something that we always do when dealing with parallel algorithms/software, and this is something you will be expected to do in the forthcoming assignments.

In this assignment, I implemented a trivial parallel algorithm. You can find the code in this archive [A0.tar.bz2](A0.tar.bz2). Your task is to pick a parallel computer, it can be your laptop or your home desktop or it can be a node in the CCR cluster, and benchmark performance of my code on this computer, then report your findings.

So how do you go about benchmarking? Well, first check the code you are supposed to benchmark. What does this code do? What are the input parameters? How do you call the parallel function, how do you call its sequential counterpart? Once you answer these questions, you will: 1) know the expected complexity of the code, 2) have means to measure \(T_1\) and 3) you will have all you need to measure \(T_p\). Some additional information that you may need:

- The code is a C++ code, and you can compile it using any C++20 compiler with OpenMP support. My recommendation is to use the GNU `g++`. You can use/edit the attached makefile to automate the compilation.
- The code already has everything in place to report the runtime (in seconds), so all you need to do is to edit the code to call the correct function depending on what you want to measure.
- The parallel function will use all available processors (i.e., cores) in your system. If you want to control how many cores it runs on, use the following invocation:

  ```bash
  OMP_NUM_THREADS=p ./a0 your_parameters
  ```

  where `p` is the number of threads/cores you want to use, and `your_parameters` are the remaining parameters you want to use (i.e., parameters you want to pass to `a0`).

Once you have the code under control, i.e., you answered the questions above and have no problem running the thing, it is time to decide how are you going to test. By now, you should know what the code does and what are the parameters. Hence, you want to decide: are you going to focus on strong or weak scaling? How many processors are you going to throw at the problem? Again, here are some suggestions:

- The code is memory hungry (why?), so the choice of the problem parameters, and hence what you are going to be able to benchmark, will depend on how much main memory your system has (why?).
- At the same time, you want your measurements to be reasonable. What that means? When you are measuring time of execution the system clock (and how you interact with it) have certain resolution. Typically, you will not be able to reliably capture runtimes shorter than `0.1s`. Just try to run `./a0` with exactly the same parameters and observe reported runtime — it will never be precisely the same (the variability is caused by what we call system jitter). Hence, you want to pick the problem sizes such that you can trust your measurements.
- Your measurements must be useful, i.e., must provide you with the data that you can interpret (e.g., use to calculate speedups and reason about scaling). Hence, think which parameters you want to change and which you can fix.

At this stage you have the tool (i.e., the code) and you have the plan (i.e., you decided how you are going to do the tests). The final step is to run the experiments, collect the data (revising experiments if needed) and then visualize the data and interpret it. Again some suggestions:

- In large parallel systems, we usually benchmark by changing the number of processors following powers of two, or something close. So for example, we could use \(p=[2,4,8,,16,32,64]\) or in some other system \(p=[1024,4096,16384,32768,65536]\). I am not expecting you to have access to such a large system (I could be wrong), so it is OK if you go for example with \(p=[2,4,6,8]\). Another aspect is that sometimes the choice may be dictated by the hardware architecture itself (e.g., how processors are connected to the memory). In any case, pick a reasonable number (usually you want \(p\) to cover more than \(3\) different choices).
- The runtime is your raw data. From the runtime you can compute speedup and efficiency, and all other metrics (e.g., computational throughput) and from that you can do your reasoning. Tabularize your runtime (recall the table we used when discussing weak and strong scaling). Then plot your speedup and plot your efficiency. Think what else you could use to gain insights. Suddenly you will see the story emerging. By the way, this is the general recommended way of reporting any benchmarking results.
- When reporting your results you always want to be precise and report all data necessary to reproduce your findings. It means that you should report details of hardware and software on which you ran the tests (and of course the remaining data we discussed above). For example, providing info about the type of the CPU, amount of RAM, version of the operating system and the compiler you used in the experiments are common practice.

## Instructions

1. Download [A0.tar.bz2](A0.tar.bz2) that contains the code you are asked to test.
2. Following the guidelines you just read, benchmark the code on the hardware of your choosing. Note that the code is parallelized for shared memory multicore processors.
3. Prepare a report in which you include the following:
    1. An answer to the question “what is the tested code doing?”
    2. An answer to the question “what is the complexity of the code with respect to the input parameters?”
    3. The data and its analysis assessing the scalability of the system you tested (following the guidelines and suggestions given in the introduction). Make sure to include a brief comment explaining/justifying the design of your experiments.
4. Compile the report into a PDF document named `A0.pdf` and submit it for grading.

## Submission

1. Make sure that your file is named correctly and contains all requested information.
2. Follow to [autograder](https://autograder.cse.buffalo.edu) to make your submission.

## Grading

1. Your report will be graded taking into account the correctness of your answers regarding questions 3.1 and 3.2 and completeness of the analysis requested in 3.3.