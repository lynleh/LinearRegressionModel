---
editor_options: 
  markdown: 
    wrap: 72
---

# LinearRegressionModel

<!-- badges: start -->

```         
[![R-CMD-check](https://github.com/username/MyPackage/actions/workflows/R-CMD-check.
```

<!-- badges: end -->

The goal of LinearRegressionModel is to provide a step-by-step, beginner
user, package that implements a linear regression model with clear
outputs, optional plotting, and comparisons to base R lm(). It also
includes a small Rcpp function (sumsq_cpp) to demonstrate C++
integration and performance benchmarking.

## Installation

You can install the development version of LinearRegressionModel like
so:

``` r
# In the package root (where DESCRIPTION lives):
# Option A: Install
devtools::install(LinearRegressionModel)

# Option B: Load without installing (for development)
devtools::load_all(LinearRegressionModel)

# Option C: GitHub
devtools::install_github("lynleh/LinearRegressionModel")
```

Function Overview

```{r}
#This is a basic explanation of what the model structure, inputs and outputs

# Fit a basic linear regression: y ~ x  linear_regression_model(x, y, na.rm = TRUE, plot = FALSE) # Inputs: 
# - x: numeric vector (predictor)
# - y: numeric vector (outcome), same length as x 
# - na.rm: remove NAs before fitting 
# - plot: if TRUE, shows scatterplot + fitted line 
# Returns: 
# - list(coef, fitted, residuals, sigma, R_squared, n, call)
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(LinearRegressionModel)

# Example data
set.seed(22)
x = 1:20
y = 2 + 0.5 * x + rnorm(20, 0, 0.2)

# Fit model
fit = linear_regression_model(x, y, plot = TRUE)

# Inspect results
fit$coefficients    # Intercept, Slope
fit$sigma           # Residual standard error
fit$R_squared       # R^2
head(fit$fitted)    # Fitted values
head(fit$residuals) # Residuals
```

## Rcpp Example

``` r
# Sum of squares via Rcpp
sumsq_cpp(1:5)
# [1] 55
```

## Benchmarking

``` r
library(bench)

bench::mark(
  linear_regression_model(data_linear_regression$x, data_linear_regression$y),
  lm(y ~ x, data = data_linear_regression),
  iterations = 100,
  check = FALSE # disables result equality check
)
```

## Testing

The unit tests are included to verify correctness and efficiency

``` r
devtools::test()
```

## Vignettes

``` r
A vignette (Basic_Linear_Regression_Model.Rmd) demonstrates correctness, efficiency, and plotting.
```

## License

MIT © Lynle Hayes
