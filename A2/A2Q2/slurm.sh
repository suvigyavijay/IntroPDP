#!/bin/bash

####################################################################################################
# IMPORTANT: set --nodes to required number of nodes in sbatch command
####################################################################################################

####### specify cluster configuration
#SBATCH --cluster=ub-hpc
#SBATCH --partition=general-compute
#SBATCH --qos=general-compute

####### select resources (here we specify required memory)
#SBATCH --mem=128G
#SBATCH --constraint=CPU-Gold-6230

####### make sure no other jobs are assigned to your nodes
#SBATCH --exclusive

####### further customizations
### name of your job
#SBATCH --job-name="isort"

### files to store stdout and stderr (%j will be replaced by the job id)
#SBATCH --output=%j.stdout
#SBATCH --error=%j.stderr

### how many cores to use on each node
#SBATCH --ntasks-per-node=1

### max time the job will run
#SBATCH --time=00:10:00

module load intel
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so

echo "JOB_ID=$SLURM_JOB_ID"
echo "hostname=$(hostname)"
echo "ARCH=$CCR_ARCH"
date -u

echo "Running n=8000000"
srun --mpi=pmi2 ./a2 8000000
echo "Running n=10000000"
srun --mpi=pmi2 ./a2 10000000
