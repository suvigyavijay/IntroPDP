#include <cuda.h>
#include <cuda_runtime.h>
#include <cmath>
#include <vector>
#include "a3.hpp"

// define a block size
const int blockSize = 256;

// gaussian function
__device__ float gaussian(float x) {
    return expf(-0.5 * x * x) / (sqrtf(2.0 * M_PI));
}

__global__ void gaussian_kde_kernel(const float* x, float* y, int n, float h) {
    // shared memory for data
    __shared__ float sdata[blockSize];
    // calculate the global thread index
    int gidx = blockIdx.x * blockDim.x + threadIdx.x;

    // check if the thread index is within the bounds of the input data
    if (gidx < n) {
        float sum = 0.0;

        // Iterate over the input data
        for (int i = 0; i < n; i += blockDim.x) {

            // load data into shared memory
            if (i + threadIdx.x < n) {
                sdata[threadIdx.x] = x[i + threadIdx.x];
            } else {
                sdata[threadIdx.x] = 0;
            }
            __syncthreads();

            float x_i = x[gidx];

            // compute sum
            for (int j = 0; j < blockDim.x; ++j) {
                if (i + j < n) {
                    float diff = (x_i - sdata[j]) / h;
                    sum += gaussian(diff);
                }
            }

            __syncthreads();
        }
    
        // update y in global memory
        y[gidx] = sum / (n * h);
    }
}

void gaussian_kde(int n, float h, const std::vector<float>& x, std::vector<float>& y) {
    float *d_x, *d_y;
    
    cudaMalloc(&d_x, n * sizeof(float));
    cudaMalloc(&d_y, n * sizeof(float));

    cudaMemcpy(d_x, x.data(), n * sizeof(float), cudaMemcpyHostToDevice);

    int gridSize = (n + blockSize - 1) / blockSize;

    gaussian_kde_kernel<<<gridSize, blockSize>>>(d_x, d_y, n, h);

    cudaMemcpy(y.data(), d_y, n * sizeof(float), cudaMemcpyDeviceToHost);

    cudaFree(d_x);
    cudaFree(d_y);
}
