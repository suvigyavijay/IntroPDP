#include <algorithm>
#include <chrono>
#include <functional>
#include <iostream>
#include <random>
#include <vector>

#include "a3.hpp"


int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cout << "usage: " << argv[0] << " n h" << std::endl;
        return -1;
    }

    int n = std::atoi(argv[1]);
    float h = std::atof(argv[2]);

    if (n < 32) {
        std::cout << "hey, n is too small even for debugging!" << std::endl;
        return -1;
    }

    if (h < 0.00001) {
        std::cout << "this bandwidth is too small" << std::endl;
        return -1;
    }

    // in and out (in is set to 1s for fun)
    std::vector<float> x(n);
    std::vector<float> y(n, 0.0);

    std::random_device rd;
    std::mt19937 gen(rd());
    std::lognormal_distribution<float> N(0.0, 1.0);
    std::generate(std::begin(x), std::end(x), std::bind(N, gen));

    // now running your awesome code from a3.hpp
    auto t0 = std::chrono::system_clock::now();

    gaussian_kde(n, h, x, y);

    auto t1 = std::chrono::system_clock::now();

    auto elapsed_par = std::chrono::duration<double>(t1 - t0);
    std::cout << elapsed_par.count() << std::endl;

    return 0;
} // main
