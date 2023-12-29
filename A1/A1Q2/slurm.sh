#!/bin/bash

####### specify cluster configuration
#SBATCH --cluster=ub-hpc
#SBATCH --partition=general-compute
#SBATCH --qos=general-compute

####### select resources (here we specify required memory)
#SBATCH --mem=128G
#SBATCH --constraint=CPU-Gold-6130

####### make sure no other jobs are assigned to your nodes
#SBATCH --exclusive

### name of your job
#SBATCH --job-name="suvigyav_A1Q2"

### files to store stdout and stderr (%%j will be replaced by the job id)
#SBATCH --output=./%j.stdout
#SBATCH --error=./%j.stderr

### how many nodes to allocate for the job
### for shared memory jobs we need only one node
#SBATCH --nodes=1

### how many cores to use on each node
#SBATCH --ntasks-per-node=16

### max time the job will run
#SBATCH --time=05:00:00

####### run commands
echo "JOB_ID=$SLURM_JOB_ID"
echo "hostname=`hostname`"
echo "ARCH=$CCR_ARCH"
date -u
printf "\n"

# for loop to loop through all the combinations of N = M with varying cpus
# for N in 10000 20000 40000 60000 80000 100000
# for cpus in 1 3 5 7 9
# each run should happen 3 times

for N in 10000 20000 40000 60000 80000 100000
do
    for cpus in 0 1 3 5 7 9
    do
        echo "running job with MEMORY=128G CPUS=0-$cpus N=$N M=$N"
        taskset -c 0-$cpus ./a1 $N $N
        taskset -c 0-$cpus ./a1 $N $N
        taskset -c 0-$cpus ./a1 $N $N
        printf "\n"
    done
done
