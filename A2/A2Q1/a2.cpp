#include <algorithm>
#include <iostream>
#include <random>
#include <vector>

#include <mpi.h>

#include "a2.hpp"


int main(int argc, char* argv[]) {
    int size, rank;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    if (argc < 2) {
        if (rank == 0) std::cout << "usage: " << argv[0] << " n" << std::endl;
        return MPI_Finalize();
    }

    if (sizeof(short int) != 2) {
        if (rank == 0) std::cout << "whooops, short int is messed up, contact your instructor!" << std::endl;
        return MPI_Finalize();
    }

    long long int n = std::atoll(argv[1]);

    if (n <= size) {
        if (rank == 0) std::cout << "hey, n is too small even for debugging!" << std::endl;
        return MPI_Finalize();
    }

    long long int loc_n = (n / size);
    if (rank == 0) loc_n = n - ((size -1) * loc_n);

    std::vector<short int> x(loc_n);

    //std::random_device rd;
    //std::mt19937 g(rd());
    std::mt19937 g(11113);
    std::uniform_int_distribution<short int> ui(-size + 1, size - 1);
    auto rng = std::bind(ui, g);

    std::generate(std::begin(x), std::end(x), rng);

    MPI_Barrier(MPI_COMM_WORLD);
    auto t0 = MPI_Wtime();

    isort(x, MPI_COMM_WORLD);

    MPI_Barrier(MPI_COMM_WORLD);
    auto t1 = MPI_Wtime();

    if (rank == 0) std::cout << (t1 - t0) << std::endl;

    return MPI_Finalize();
} // main
