#include <cmath>
#include <vector>
#include "a3.hpp"

float gaussian_fx_cpu(float x, float h) {
    return exp(-x * x / (2 * h * h)) / (sqrt(2 * M_PI) * h);
}

void gaussian_kde_cpu(int n, float h, const std::vector<float>& x, std::vector<float>& y) {
    for (int idx = 0; idx < n; ++idx) {
        float sum = 0.0f;
        for (int i = 0; i < n; ++i) {
            sum += gaussian_fx_cpu((x[idx] - x[i]) / h, 1.0f);
        }
        y[idx] = sum / (n * h);
    }
}
