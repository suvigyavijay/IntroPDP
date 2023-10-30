/*  SUVIGYA
 *  VIJAY
 *  suvigyav
 */

#ifndef A1_HPP
#define A1_HPP

#include <vector>
#include <omp.h>

std::vector<float> compute_col_sums(const std::vector<float>& K, int kernel_size) {
    std::vector<float> col_sums(kernel_size, 0.0f);

    for (int col = 0; col < kernel_size; col++) {
        for (int row = 0; row < kernel_size; row++) {
            col_sums[col] += K[row * kernel_size + col];
        }
    }

    return col_sums;
}

void compute_row_sums(std::vector<float>& A, long long int n, long long int m) {
    int num_threads = omp_get_max_threads();
    int chunk_size = (n + num_threads - 1) / num_threads;
    // Iterate over each row (excluding the first and last rows)
    #pragma omp parallel for default(none) shared(A, n, m, chunk_size) schedule(static, chunk_size)
    for (long long int i = 0; i < n; i++) {
        float temp = A[i * m];
        // Iterate over each column (excluding the first and last columns)
        for (long long int j = 1; j < m - 1; j++) {
            if (j>1) {
                float current = A[i * m + j];
                A[i * m + j] = A[i * m + (j - 1)] + A[i * m + (j + 1)] - temp;
                temp = current;
            } else {
                A[i * m + j] = A[i * m + (j - 1)] + A[i * m + (j + 1)] + A[i * m + j];
            }
        }
    }
}

void compute_col_multiply(std::vector<float>& A, long long int n, long long int m, const std::vector<float>& col_sums) {
    int num_threads = omp_get_max_threads();
    int chunk_size = (m + num_threads - 1) / num_threads;
    // Iterate over each column (excluding the first and last columns)
    #pragma omp parallel for default(none) shared(A, n, m, col_sums, chunk_size) schedule(static, chunk_size)
    for (long long int j = 1; j < m - 1; j++) {
        float temp = A[j];
        // Iterate over each row (excluding the first and last rows)
        for (long long int i = 1; i < n - 1; i++) {
            if (i > 1) {
                float current = A[i * m + j];
                A[i * m + j] = temp * col_sums[0] + A[i * m + j] * col_sums[1] + A[(i + 1) * m + j] * col_sums[2];
                temp = current;
            } else {
                temp = A[i * m + j];
                A[i * m + j] = A[(i - 1) * m + j] * col_sums[0] + A[i * m + j] * col_sums[1] + A[(i + 1) * m + j] * col_sums[2];
            }
        }
    }
}

void filter_2d(long long int n, long long int m, const std::vector<float>& K, std::vector<float>& A) {
    const int kernel_size = 3;

    std::vector<float> col_sums = compute_col_sums(K, kernel_size);

    // Create copies of the first and last rows
    std::vector<float> first_row_copy(A.begin(), A.begin() + m);
    std::vector<float> last_row_copy(A.end() - m, A.end());

    compute_row_sums(A, n, m);

    compute_col_multiply(A, n, m, col_sums);

    // Overwrite the first and last rows
    std::copy(first_row_copy.begin(), first_row_copy.end(), A.begin());
    std::copy(last_row_copy.begin(), last_row_copy.end(), A.end() - m);

} // filter_2d

#endif // A1_HPP
