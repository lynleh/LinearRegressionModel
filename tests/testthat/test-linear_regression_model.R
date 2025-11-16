library(testthat)
test_that("linear_regression_model matches lm coefficients closely", {
  data(data_linear_regression)
  fit = linear_regression_model(data_linear_regression$x,
                                data_linear_regression$y)
  lm_fit = lm(y ~ x, data = data_linear_regression)
  expect_true(is.numeric(fit$coefficients))
  expect_equal(unname(fit$coefficients), unname(coef(lm_fit)), tolerance = 1e-8)

})

test_that("linear_regression_model handles NA values when na.rm = TRUE", {
  x = c(1, 2, NA, 4)
  y = c(2, 4, 6, 8)
  fit = linear_regression_model(x, y, na.rm = TRUE)
  expect_equal(fit$n, 3)
})
