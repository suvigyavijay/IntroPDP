/*  SUVIGYA
 *  VIJAY
 *  suvigyav
 */

#ifndef A3_HPP
#define A3_HPP

#include <vector>

void gaussian_kde(int n, float h, const std::vector<float>& x, std::vector<float>& y);

void gaussian_kde_cpu(int n, float h, const std::vector<float>& x, std::vector<float>& y);

#endif // A3_HPP
