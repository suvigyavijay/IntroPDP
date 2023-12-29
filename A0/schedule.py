"""
Name: schedule.py
Author: Suvigya Vijay
Description: Script for writing and scheduling tasks using Slurm
"""

import subprocess
import argparse

def write_slurm_script(script_name, job_name, arch, time, nodes, memory, cpus, commands):
    """
    Write a slurm script
    """
    with open(script_name, 'w') as f:
        f.write("#!/bin/bash\n")
        f.write("\n")
        f.write("####### specify cluster configuration\n")
        f.write("#SBATCH --cluster=ub-hpc\n")
        f.write("#SBATCH --partition=general-compute\n")
        f.write("#SBATCH --qos=general-compute\n")
        f.write("\n")
        f.write("####### select resources (here we specify required memory)\n")
        f.write("#SBATCH --mem=%s\n" % memory)
        f.write("#SBATCH --constraint=%s\n" % arch)
        f.write("#SBATCH --constraint=CPU-Gold-6130\n")
        f.write("\n")
        f.write("####### make sure no other jobs are assigned to your nodes\n")
        f.write("#SBATCH --exclusive\n")
        f.write("\n")
        f.write("####### further customizations\n")
        f.write("### name of your job\n")
        f.write("#SBATCH --job-name=\"%s\"\n" % job_name)
        f.write("\n")
        f.write("### files to store stdout and stderr (%%j will be replaced by the job id)\n")
        f.write("#SBATCH --output=./test/%j.log\n")
        f.write("#SBATCH --error=./test/%j.log\n")
        f.write("\n")
        f.write("### how many nodes to allocate for the job\n")
        f.write("### for shared memory jobs we need only one node\n")
        f.write("#SBATCH --nodes=%s\n" % nodes)
        f.write("\n")
        f.write("### how many cores to use on each node\n")
        f.write("#SBATCH --ntasks-per-node=%s\n" % cpus)
        f.write("\n")
        f.write("### max time the job will run\n")
        f.write("#SBATCH --time=%s\n" % time)
        f.write("\n")
        # f.write("####### load modules\n")
        # f.write("module load intel\n")
        # f.write("\n")
        f.write("####### run commands\n")
        for command in commands:
            f.write("%s\n" % command)

def schedule_slurm_script(script_name):
    """
    Schedule a slurm script
    """
    p = subprocess.run(["sbatch", script_name], stdout=subprocess.PIPE)
    # check if job was submitted successfully
    if p.returncode != 0:
        raise Exception("Error submitting job")
    
    # get job id from output "Submitted batch job 13573408 on cluster ub-hpc"
    job_id = p.stdout.decode("utf-8").split(" ")[3]

    return job_id

def get_slurm_job_status(job_id):
    """
    Get the status of a slurm job
    """
    p = subprocess.run(["squeue", "-j", job_id, "-h", "-o", "%T"], stdout=subprocess.PIPE)
    # check if job status was retrieved successfully
    if p.returncode != 0:
        raise Exception("Error retrieving job status")
    
    # get job status from output
    job_status = p.stdout.decode("utf-8").strip()

    return job_status

def make_commands(max_input_size, max_cpus, memory, arch):
    """
    Make commands for slurm script with variations of seq and omp given below
    
    echo "running SEQ with MEMORY=32000 N=100000 M=10000"
    ./a0_avx_seq 100000 10000
    printf "\n"

    echo "running OMP with MEMORY=32000 CPUS=0 N=100000 M=10000"
    taskset -c 0 ./a0_avx_omp 100000 10000
    printf "\n"

    echo "running OMP with MEMORY=32000 CPUS=0-1 N=100000 M=10000"
    taskset -c 0-1 ./a0_avx_omp 100000 10000
    printf "\n"

    echo "running OMP with MEMORY=32000 CPUS=0-3 N=100000 M=10000"
    taskset -c 0-3 ./a0_avx_omp 100000 10000
    printf "\n"

    echo "running OMP with MEMORY=32000 CPUS=0-7 N=100000 M=10000"
    taskset -c 0-7 ./a0_avx_omp 100000 10000
    printf "\n"

    echo "running OMP with MEMORY=32000 CPUS=0-15 N=100000 M=10000"
    taskset -c 0-15 ./a0_avx_omp 100000 10000
    printf "\n"
    """

    commands = []
    commands.append("echo \"JOB_ID=$SLURM_JOB_ID\"")
    commands.append("echo \"hostname=`hostname`\"")
    commands.append("echo \"ARCH=$CCR_ARCH\"")
    commands.append("date -u")
    commands.append("printf \"\\n\"")

    # input_size ranging from 100, 1000, 10000, 100000, ..., max_input_size
    # N and M are input_size independent of each other
    # command: ./a0_avx_seq %s %s" % (N, M)
    # command: taskset -c 0-%s ./a0_avx_omp %s %s" % (cpus-1, N, M)
    N = 100
    M = 100
    while N <= max_input_size:
        while M <= max_input_size:
            commands.append("echo \"running SEQ with MEMORY=%s N=%s M=%s\"" % (memory, N, M))
            commands.append("./a0_%s_seq %s %s" % (arch.lower(), N, M))
            commands.append("printf \"\\n\"")

            cpus = 1
            while cpus <= max_cpus:
                commands.append("echo \"running OMP with MEMORY=%s CPUS=0-%s N=%s M=%s\"" % (memory, cpus-1, N, M))
                commands.append("taskset -c 0-%s ./a0_%s_omp %s %s" % (cpus-1, arch.lower(), N, M))
                commands.append("printf \"\\n\"")
                cpus *= 2

            M *= 10
        N *= 10
        M = 100

    return commands


if __name__ == "__main__":
    # parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("-sn", "--script_name", type=str, default="test.sh", help="Name of slurm script")
    parser.add_argument("-jn", "--job_name", type=str, default="test", help="Name of slurm job")
    parser.add_argument("-t", "--time", type=str, default="00:10:00", help="Time for slurm job")
    parser.add_argument("-n", "--nodes", type=str, default="1", help="Number of nodes for slurm job")
    parser.add_argument("-m", "--memory", type=str, default="1G", help="Memory for slurm job")
    parser.add_argument("-c", "--max_cpus", type=str, default="1", help="Number of cpus for slurm job")
    parser.add_argument("-mi", "--max_input_size", type=int, default=100000, help="Maximum input size for slurm job")
    parser.add_argument("-a", "--arch", type=str, default="AVX", help="Architecture for slurm job")

    args = parser.parse_args()

    # make commands
    commands = make_commands(args.max_input_size, int(args.max_cpus), args.memory, args.arch)

    # write slurm script
    write_slurm_script(args.script_name, args.job_name, args.arch, args.time, args.nodes, args.memory, args.max_cpus, commands)
    
    # schedule slurm script
    job_id = schedule_slurm_script(args.script_name)
    print("Job ID: %s" % job_id)

    # get slurm job status
    job_status = get_slurm_job_status(job_id)
    print("Job Status: %s" % job_status)
