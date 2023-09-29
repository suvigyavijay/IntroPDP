#!/bin/bash

####### specify cluster configuration
#SBATCH --cluster=ub-hpc
#SBATCH --partition=general-compute
#SBATCH --qos=general-compute

####### select resources (here we specify required memory)
#SBATCH --mem=32000
#SBATCH --constraint=AVX512

####### make sure no other jobs are assigned to your nodes
#SBATCH --exclusive

####### further customizations
### name of your job
#SBATCH --job-name="suvigyav-pdp-test"

### files to store stdout and stderr (%j will be replaced by the job id)
#SBATCH --output=%j.stdout
#SBATCH --error=%j.stderr

### how many nodes to allocate for the job
### for shared memory jobs we need only one node
#SBATCH --nodes=1

### how many cores to use on each node
#SBATCH --ntasks-per-node=32

### max time the job will run
#SBATCH --time=00:30:00


# here go regular commands, these commands will be run
# on the first node allocated to the job
echo "JOB_ID=$SLURM_JOB_ID"
echo "hostname=`hostname`"
date -u
printf "\n"

# in the similar way we run OMP app
# tasket limits the number of cores we are going to use
echo "running SEQ with MEMORY=32000 N=100000 M=10000"
./a0_avx512_seq 100000 10000
printf "\n"

echo "running OMP with MEMORY=32000 CPUS=0 N=100000 M=10000"
taskset -c 0 ./a0_avx512_omp 100000 10000
printf "\n"

echo "running OMP with MEMORY=32000 CPUS=0-1 N=100000 M=10000"
taskset -c 0-1 ./a0_avx512_omp 100000 10000
printf "\n"

echo "running OMP with MEMORY=32000 CPUS=0-3 N=100000 M=10000"
taskset -c 0-3 ./a0_avx512_omp 100000 10000
printf "\n"

echo "running OMP with MEMORY=32000 CPUS=0-7 N=100000 M=10000"
taskset -c 0-7 ./a0_avx512_omp 100000 10000
printf "\n"

echo "running OMP with MEMORY=32000 CPUS=0-15 N=100000 M=10000"
taskset -c 0-15 ./a0_avx512_omp 100000 10000
printf "\n"

echo "running OMP with MEMORY=32000 CPUS=0-32 N=100000 M=10000"
taskset -c 0-32 ./a0_avx512_omp 100000 10000
printf "\n"

