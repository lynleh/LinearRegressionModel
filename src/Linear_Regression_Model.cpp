#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
double sumsq_cpp(NumericVector x) {
  double s = 0.0;
  for (int i = 0; i < x.size(); ++i) {
    s += x[i] * x[i];
  }
  return s;
}

