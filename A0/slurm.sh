#!/bin/bash

####### specify cluster configuration
#SBATCH --cluster=ub-hpc
#SBATCH --partition=general-compute
#SBATCH --qos=general-compute

####### select resources (here we specify required memory)
#SBATCH --mem=192G
#SBATCH --constraint=AVX512
#SBATCH --constraint=CPU-Gold-6130

####### make sure no other jobs are assigned to your nodes
#SBATCH --exclusive

####### further customizations
### name of your job
#SBATCH --job-name="test"

### files to store stdout and stderr (%%j will be replaced by the job id)
#SBATCH --output=./test/%j.log
#SBATCH --error=./test/%j.log

### how many nodes to allocate for the job
### for shared memory jobs we need only one node
#SBATCH --nodes=1

### how many cores to use on each node
#SBATCH --ntasks-per-node=32

### max time the job will run
#SBATCH --time=01:00:00

####### run commands
echo "JOB_ID=$SLURM_JOB_ID"
echo "hostname=`hostname`"
echo "ARCH=$CCR_ARCH"
date -u
printf "\n"
echo "running SEQ with MEMORY=192G N=100 M=100"
./a0_avx512_seq 100 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=100 M=100"
taskset -c 0-0 ./a0_avx512_omp 100 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=100 M=100"
taskset -c 0-1 ./a0_avx512_omp 100 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=100 M=100"
taskset -c 0-3 ./a0_avx512_omp 100 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=100 M=100"
taskset -c 0-7 ./a0_avx512_omp 100 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=100 M=100"
taskset -c 0-15 ./a0_avx512_omp 100 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=100 M=100"
taskset -c 0-31 ./a0_avx512_omp 100 100
printf "\n"
echo "running SEQ with MEMORY=192G N=100 M=1000"
./a0_avx512_seq 100 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=100 M=1000"
taskset -c 0-0 ./a0_avx512_omp 100 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=100 M=1000"
taskset -c 0-1 ./a0_avx512_omp 100 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=100 M=1000"
taskset -c 0-3 ./a0_avx512_omp 100 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=100 M=1000"
taskset -c 0-7 ./a0_avx512_omp 100 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=100 M=1000"
taskset -c 0-15 ./a0_avx512_omp 100 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=100 M=1000"
taskset -c 0-31 ./a0_avx512_omp 100 1000
printf "\n"
echo "running SEQ with MEMORY=192G N=100 M=10000"
./a0_avx512_seq 100 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=100 M=10000"
taskset -c 0-0 ./a0_avx512_omp 100 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=100 M=10000"
taskset -c 0-1 ./a0_avx512_omp 100 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=100 M=10000"
taskset -c 0-3 ./a0_avx512_omp 100 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=100 M=10000"
taskset -c 0-7 ./a0_avx512_omp 100 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=100 M=10000"
taskset -c 0-15 ./a0_avx512_omp 100 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=100 M=10000"
taskset -c 0-31 ./a0_avx512_omp 100 10000
printf "\n"
echo "running SEQ with MEMORY=192G N=100 M=100000"
./a0_avx512_seq 100 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=100 M=100000"
taskset -c 0-0 ./a0_avx512_omp 100 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=100 M=100000"
taskset -c 0-1 ./a0_avx512_omp 100 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=100 M=100000"
taskset -c 0-3 ./a0_avx512_omp 100 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=100 M=100000"
taskset -c 0-7 ./a0_avx512_omp 100 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=100 M=100000"
taskset -c 0-15 ./a0_avx512_omp 100 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=100 M=100000"
taskset -c 0-31 ./a0_avx512_omp 100 100000
printf "\n"
echo "running SEQ with MEMORY=192G N=100 M=1000000"
./a0_avx512_seq 100 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=100 M=1000000"
taskset -c 0-0 ./a0_avx512_omp 100 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=100 M=1000000"
taskset -c 0-1 ./a0_avx512_omp 100 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=100 M=1000000"
taskset -c 0-3 ./a0_avx512_omp 100 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=100 M=1000000"
taskset -c 0-7 ./a0_avx512_omp 100 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=100 M=1000000"
taskset -c 0-15 ./a0_avx512_omp 100 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=100 M=1000000"
taskset -c 0-31 ./a0_avx512_omp 100 1000000
printf "\n"
echo "running SEQ with MEMORY=192G N=1000 M=100"
./a0_avx512_seq 1000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=1000 M=100"
taskset -c 0-0 ./a0_avx512_omp 1000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=1000 M=100"
taskset -c 0-1 ./a0_avx512_omp 1000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=1000 M=100"
taskset -c 0-3 ./a0_avx512_omp 1000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=1000 M=100"
taskset -c 0-7 ./a0_avx512_omp 1000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=1000 M=100"
taskset -c 0-15 ./a0_avx512_omp 1000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=1000 M=100"
taskset -c 0-31 ./a0_avx512_omp 1000 100
printf "\n"
echo "running SEQ with MEMORY=192G N=1000 M=1000"
./a0_avx512_seq 1000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=1000 M=1000"
taskset -c 0-0 ./a0_avx512_omp 1000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=1000 M=1000"
taskset -c 0-1 ./a0_avx512_omp 1000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=1000 M=1000"
taskset -c 0-3 ./a0_avx512_omp 1000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=1000 M=1000"
taskset -c 0-7 ./a0_avx512_omp 1000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=1000 M=1000"
taskset -c 0-15 ./a0_avx512_omp 1000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=1000 M=1000"
taskset -c 0-31 ./a0_avx512_omp 1000 1000
printf "\n"
echo "running SEQ with MEMORY=192G N=1000 M=10000"
./a0_avx512_seq 1000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=1000 M=10000"
taskset -c 0-0 ./a0_avx512_omp 1000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=1000 M=10000"
taskset -c 0-1 ./a0_avx512_omp 1000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=1000 M=10000"
taskset -c 0-3 ./a0_avx512_omp 1000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=1000 M=10000"
taskset -c 0-7 ./a0_avx512_omp 1000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=1000 M=10000"
taskset -c 0-15 ./a0_avx512_omp 1000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=1000 M=10000"
taskset -c 0-31 ./a0_avx512_omp 1000 10000
printf "\n"
echo "running SEQ with MEMORY=192G N=1000 M=100000"
./a0_avx512_seq 1000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=1000 M=100000"
taskset -c 0-0 ./a0_avx512_omp 1000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=1000 M=100000"
taskset -c 0-1 ./a0_avx512_omp 1000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=1000 M=100000"
taskset -c 0-3 ./a0_avx512_omp 1000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=1000 M=100000"
taskset -c 0-7 ./a0_avx512_omp 1000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=1000 M=100000"
taskset -c 0-15 ./a0_avx512_omp 1000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=1000 M=100000"
taskset -c 0-31 ./a0_avx512_omp 1000 100000
printf "\n"
echo "running SEQ with MEMORY=192G N=1000 M=1000000"
./a0_avx512_seq 1000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=1000 M=1000000"
taskset -c 0-0 ./a0_avx512_omp 1000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=1000 M=1000000"
taskset -c 0-1 ./a0_avx512_omp 1000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=1000 M=1000000"
taskset -c 0-3 ./a0_avx512_omp 1000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=1000 M=1000000"
taskset -c 0-7 ./a0_avx512_omp 1000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=1000 M=1000000"
taskset -c 0-15 ./a0_avx512_omp 1000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=1000 M=1000000"
taskset -c 0-31 ./a0_avx512_omp 1000 1000000
printf "\n"
echo "running SEQ with MEMORY=192G N=10000 M=100"
./a0_avx512_seq 10000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=10000 M=100"
taskset -c 0-0 ./a0_avx512_omp 10000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=10000 M=100"
taskset -c 0-1 ./a0_avx512_omp 10000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=10000 M=100"
taskset -c 0-3 ./a0_avx512_omp 10000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=10000 M=100"
taskset -c 0-7 ./a0_avx512_omp 10000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=10000 M=100"
taskset -c 0-15 ./a0_avx512_omp 10000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=10000 M=100"
taskset -c 0-31 ./a0_avx512_omp 10000 100
printf "\n"
echo "running SEQ with MEMORY=192G N=10000 M=1000"
./a0_avx512_seq 10000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=10000 M=1000"
taskset -c 0-0 ./a0_avx512_omp 10000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=10000 M=1000"
taskset -c 0-1 ./a0_avx512_omp 10000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=10000 M=1000"
taskset -c 0-3 ./a0_avx512_omp 10000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=10000 M=1000"
taskset -c 0-7 ./a0_avx512_omp 10000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=10000 M=1000"
taskset -c 0-15 ./a0_avx512_omp 10000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=10000 M=1000"
taskset -c 0-31 ./a0_avx512_omp 10000 1000
printf "\n"
echo "running SEQ with MEMORY=192G N=10000 M=10000"
./a0_avx512_seq 10000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=10000 M=10000"
taskset -c 0-0 ./a0_avx512_omp 10000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=10000 M=10000"
taskset -c 0-1 ./a0_avx512_omp 10000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=10000 M=10000"
taskset -c 0-3 ./a0_avx512_omp 10000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=10000 M=10000"
taskset -c 0-7 ./a0_avx512_omp 10000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=10000 M=10000"
taskset -c 0-15 ./a0_avx512_omp 10000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=10000 M=10000"
taskset -c 0-31 ./a0_avx512_omp 10000 10000
printf "\n"
echo "running SEQ with MEMORY=192G N=10000 M=100000"
./a0_avx512_seq 10000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=10000 M=100000"
taskset -c 0-0 ./a0_avx512_omp 10000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=10000 M=100000"
taskset -c 0-1 ./a0_avx512_omp 10000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=10000 M=100000"
taskset -c 0-3 ./a0_avx512_omp 10000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=10000 M=100000"
taskset -c 0-7 ./a0_avx512_omp 10000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=10000 M=100000"
taskset -c 0-15 ./a0_avx512_omp 10000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=10000 M=100000"
taskset -c 0-31 ./a0_avx512_omp 10000 100000
printf "\n"
echo "running SEQ with MEMORY=192G N=10000 M=1000000"
./a0_avx512_seq 10000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=10000 M=1000000"
taskset -c 0-0 ./a0_avx512_omp 10000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=10000 M=1000000"
taskset -c 0-1 ./a0_avx512_omp 10000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=10000 M=1000000"
taskset -c 0-3 ./a0_avx512_omp 10000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=10000 M=1000000"
taskset -c 0-7 ./a0_avx512_omp 10000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=10000 M=1000000"
taskset -c 0-15 ./a0_avx512_omp 10000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=10000 M=1000000"
taskset -c 0-31 ./a0_avx512_omp 10000 1000000
printf "\n"
echo "running SEQ with MEMORY=192G N=100000 M=100"
./a0_avx512_seq 100000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=100000 M=100"
taskset -c 0-0 ./a0_avx512_omp 100000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=100000 M=100"
taskset -c 0-1 ./a0_avx512_omp 100000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=100000 M=100"
taskset -c 0-3 ./a0_avx512_omp 100000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=100000 M=100"
taskset -c 0-7 ./a0_avx512_omp 100000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=100000 M=100"
taskset -c 0-15 ./a0_avx512_omp 100000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=100000 M=100"
taskset -c 0-31 ./a0_avx512_omp 100000 100
printf "\n"
echo "running SEQ with MEMORY=192G N=100000 M=1000"
./a0_avx512_seq 100000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=100000 M=1000"
taskset -c 0-0 ./a0_avx512_omp 100000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=100000 M=1000"
taskset -c 0-1 ./a0_avx512_omp 100000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=100000 M=1000"
taskset -c 0-3 ./a0_avx512_omp 100000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=100000 M=1000"
taskset -c 0-7 ./a0_avx512_omp 100000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=100000 M=1000"
taskset -c 0-15 ./a0_avx512_omp 100000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=100000 M=1000"
taskset -c 0-31 ./a0_avx512_omp 100000 1000
printf "\n"
echo "running SEQ with MEMORY=192G N=100000 M=10000"
./a0_avx512_seq 100000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=100000 M=10000"
taskset -c 0-0 ./a0_avx512_omp 100000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=100000 M=10000"
taskset -c 0-1 ./a0_avx512_omp 100000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=100000 M=10000"
taskset -c 0-3 ./a0_avx512_omp 100000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=100000 M=10000"
taskset -c 0-7 ./a0_avx512_omp 100000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=100000 M=10000"
taskset -c 0-15 ./a0_avx512_omp 100000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=100000 M=10000"
taskset -c 0-31 ./a0_avx512_omp 100000 10000
printf "\n"
echo "running SEQ with MEMORY=192G N=100000 M=100000"
./a0_avx512_seq 100000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=100000 M=100000"
taskset -c 0-0 ./a0_avx512_omp 100000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=100000 M=100000"
taskset -c 0-1 ./a0_avx512_omp 100000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=100000 M=100000"
taskset -c 0-3 ./a0_avx512_omp 100000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=100000 M=100000"
taskset -c 0-7 ./a0_avx512_omp 100000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=100000 M=100000"
taskset -c 0-15 ./a0_avx512_omp 100000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=100000 M=100000"
taskset -c 0-31 ./a0_avx512_omp 100000 100000
printf "\n"
echo "running SEQ with MEMORY=192G N=100000 M=1000000"
./a0_avx512_seq 100000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=100000 M=1000000"
taskset -c 0-0 ./a0_avx512_omp 100000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=100000 M=1000000"
taskset -c 0-1 ./a0_avx512_omp 100000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=100000 M=1000000"
taskset -c 0-3 ./a0_avx512_omp 100000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=100000 M=1000000"
taskset -c 0-7 ./a0_avx512_omp 100000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=100000 M=1000000"
taskset -c 0-15 ./a0_avx512_omp 100000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=100000 M=1000000"
taskset -c 0-31 ./a0_avx512_omp 100000 1000000
printf "\n"
echo "running SEQ with MEMORY=192G N=1000000 M=100"
./a0_avx512_seq 1000000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=1000000 M=100"
taskset -c 0-0 ./a0_avx512_omp 1000000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=1000000 M=100"
taskset -c 0-1 ./a0_avx512_omp 1000000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=1000000 M=100"
taskset -c 0-3 ./a0_avx512_omp 1000000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=1000000 M=100"
taskset -c 0-7 ./a0_avx512_omp 1000000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=1000000 M=100"
taskset -c 0-15 ./a0_avx512_omp 1000000 100
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=1000000 M=100"
taskset -c 0-31 ./a0_avx512_omp 1000000 100
printf "\n"
echo "running SEQ with MEMORY=192G N=1000000 M=1000"
./a0_avx512_seq 1000000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=1000000 M=1000"
taskset -c 0-0 ./a0_avx512_omp 1000000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=1000000 M=1000"
taskset -c 0-1 ./a0_avx512_omp 1000000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=1000000 M=1000"
taskset -c 0-3 ./a0_avx512_omp 1000000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=1000000 M=1000"
taskset -c 0-7 ./a0_avx512_omp 1000000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=1000000 M=1000"
taskset -c 0-15 ./a0_avx512_omp 1000000 1000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=1000000 M=1000"
taskset -c 0-31 ./a0_avx512_omp 1000000 1000
printf "\n"
echo "running SEQ with MEMORY=192G N=1000000 M=10000"
./a0_avx512_seq 1000000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=1000000 M=10000"
taskset -c 0-0 ./a0_avx512_omp 1000000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=1000000 M=10000"
taskset -c 0-1 ./a0_avx512_omp 1000000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=1000000 M=10000"
taskset -c 0-3 ./a0_avx512_omp 1000000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=1000000 M=10000"
taskset -c 0-7 ./a0_avx512_omp 1000000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=1000000 M=10000"
taskset -c 0-15 ./a0_avx512_omp 1000000 10000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=1000000 M=10000"
taskset -c 0-31 ./a0_avx512_omp 1000000 10000
printf "\n"
echo "running SEQ with MEMORY=192G N=1000000 M=100000"
./a0_avx512_seq 1000000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=1000000 M=100000"
taskset -c 0-0 ./a0_avx512_omp 1000000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=1000000 M=100000"
taskset -c 0-1 ./a0_avx512_omp 1000000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=1000000 M=100000"
taskset -c 0-3 ./a0_avx512_omp 1000000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=1000000 M=100000"
taskset -c 0-7 ./a0_avx512_omp 1000000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=1000000 M=100000"
taskset -c 0-15 ./a0_avx512_omp 1000000 100000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=1000000 M=100000"
taskset -c 0-31 ./a0_avx512_omp 1000000 100000
printf "\n"
echo "running SEQ with MEMORY=192G N=1000000 M=1000000"
./a0_avx512_seq 1000000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-0 N=1000000 M=1000000"
taskset -c 0-0 ./a0_avx512_omp 1000000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-1 N=1000000 M=1000000"
taskset -c 0-1 ./a0_avx512_omp 1000000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-3 N=1000000 M=1000000"
taskset -c 0-3 ./a0_avx512_omp 1000000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-7 N=1000000 M=1000000"
taskset -c 0-7 ./a0_avx512_omp 1000000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-15 N=1000000 M=1000000"
taskset -c 0-15 ./a0_avx512_omp 1000000 1000000
printf "\n"
echo "running OMP with MEMORY=192G CPUS=0-31 N=1000000 M=1000000"
taskset -c 0-31 ./a0_avx512_omp 1000000 1000000
printf "\n"
