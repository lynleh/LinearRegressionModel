#' Sum of squares via Rcpp
#'
#' @param x Numeric vector
#' @return Numeric scalar
#' @examples
#' sumsq_cpp(1:5)
#'
#' @export
sumsq_cpp <- function(x) {
  .Call(`_LinearRegressionModel_sumsq_cpp`, x)
}
