"""
Name: analyze.py
Author: Suvigya Vijay
Description: Script for analyzing benchmark data for parallelization
"""
import os
import argparse

def read_benchmark_data(benchmark_log):
    """
    Read benchmark data from log file
    Get job id, hostname, architecture, seq/omp, memory, cpus, n, m, time
    Lines with "Killed" are failed jobs, include -1 for time
    Ignore slurmstepd error lines
    """
    # open file and parse lines
    with open(benchmark_log, 'r') as f:
        lines = f.readlines()

    # get job_id, hostname, arch, date
    job_id = lines[0].split('=')[1].strip()
    hostname = lines[1].split('=')[1].strip()
    arch = lines[2].split('=')[1].strip()
    date = lines[3].strip()

    # get benchmark data
    benchmark_data = []
    for i in range(5, len(lines), 3):
        # check slurmstepd error
        if "slurmstepd" in lines[i]:
            break

        # get seq/omp, memory, cpus, n, m
        seq_omp = lines[i].split(' ')[1]
        if seq_omp.lower() == "seq":
            memory = lines[i].split(' ')[3].split('=')[1].strip()
            cpus = 1
            n = int(lines[i].split(' ')[4].split('=')[1].strip())
            m = int(lines[i].split(' ')[5].split('=')[1].strip())
        else:
            memory = lines[i].split(' ')[3].split('=')[1].strip()
            cpus = lines[i].split(' ')[4].split('=')[1].strip()
            cpus = int(cpus.split('-')[1]) + 1
            n = int(lines[i].split(' ')[5].split('=')[1].strip())
            m = int(lines[i].split(' ')[6].split('=')[1].strip())

        # get time
        time = lines[i+1].strip()

        # failed job
        if "Killed" in time:
            time = -1

        # append to benchmark_data
        benchmark_data.append((job_id, hostname, arch, date, seq_omp, memory, cpus, n, m, n*m, time))

    return benchmark_data

def print_benchmark_data(benchmark_data):
    """
    Pretty print benchmark data as table sorted by n*m, -1*seq/omp, cpus
    """
    # print header
    print("JOB_ID\tHOSTNAME\tARCH\tDATE\tSEQ/OMP\tMEMORY\tCPUS\tN\tM\tN*M\tTIME")

    # sort benchmark data
    benchmark_data.sort(key=lambda x: (x[9], -1*x[4], x[6]))
    for benchmark in benchmark_data:
        print("%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s" % benchmark)


if __name__ == "__main__":
    # parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("-l", "--log", type=str, default="benchmark.log", help="Name of benchmark log")
    args = parser.parse_args()

    # read benchmark data
    benchmark_data = read_benchmark_data(args.log)

    # print benchmark data
    print_benchmark_data(benchmark_data)
