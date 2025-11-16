#' Fit a basic linear regression: y ~ x
#'
#' This function uses a step by step process to fit a straight line to data with one predictor (x) and one outcome (y).
#' It computes the intercept and slope using ordinary least squares (OLS).
#' It also returns fitted values, residuals, and basic summary information.
#' Optionally, it produces a plot showing the data points and fitted regression line.

#' @importFrom graphics plot abline legend
#' @importFrom stats lm fitted coef
#' @importFrom utils head
#' @importFrom bench mark

#' @param x A numeric vector of predictor values.
#' @param y A numeric vector of outcome values, same length as x.
#' @param na.rm Logical; if TRUE, rows with NA in x or y are removed before fitting.
#' @param plot Logical; if TRUE, a plot of data and regression line is shown.
#' @return A list with components: coefficients (intercept, slope), fitted, residuals,
#'         sigma (residual standard error), R2 (coefficient of determination),
#'         n (number of observations), call (the function call).
#' @examples
#' x = 1:10
#' y = 2 + 0.5 * x + rnorm(10, 0, 0.1)
#' fit = linear_regression_model(x, y, plot = TRUE)
#' fit$coefficients
#' @export

linear_regression_model = function(x, y, na.rm = TRUE, plot = FALSE) {
  # Save the function call for reporting
  cl = match.call()

  # Step 1: Check inputs are provided
  if (missing(x) || missing(y)) {
    stop("Please provide both x and y.")
  }

  # Step 2: Check types are numeric vectors
  if (!is.numeric(x) || !is.numeric(y)) {
    stop("x and y must be numeric vectors.")
  }

  # Step 3: Check lengths match
  if (length(x) != length(y)) {
    stop("x and y must have the same length.")
  }

  # Step 4: Optionally remove missing values
  if (na.rm) {
    keep = !(is.na(x) | is.na(y))
    x = x[keep]
    y = y[keep]
  }

  # Step 5: Check we have enough data
  n = length(x)
  if (n < 2) {
    stop("Not enough data to fit a line. Need at least 2 points.")
  }

  # Step 6: Create the design matrix with a column of 1s (intercept) and x
  X = cbind(Intercept = rep(1, n), x = x)

  # Step 7: Compute X'X and X'y
  XtX = t(X) %*% X
  Xty = t(X) %*% y

  # Step 8: Check if XtX is invertible (no perfect collinearity)
  detXtX = det(XtX)
  if (abs(detXtX) < .Machine$double.eps) {
    stop("The design matrix is singular; cannot fit the model.")
  }

  # Step 9: Solve for coefficients (beta)
  beta = solve(XtX, Xty)
  intercept = as.numeric(beta[1])
  slope = as.numeric(beta[2])

  # Step 10: Compute fitted values and residuals
  fitted = as.numeric(X %*% beta)
  residuals = y - fitted

  # Step 11: Residual standard error (sigma), using the residual sum of squares (rss)
  degree_freedom = n - 2
  residual_sum_squares <- sum(residuals^2)
  sigma = sqrt(residual_sum_squares / degree_freedom)

  # Step 12: Compute R-squared using total sum of squares (tss)
  total_sum_squares = sum( (y - mean(y))^2 )
  R_squared = 1 - residual_sum_squares / total_sum_squares

  # Step 13: Create a clean result list
  result <- list(
    coefficients = c(Intercept = intercept, Slope = slope),
    fitted = fitted,
    residuals = residuals,
    sigma = sigma,
    R_squared = R_squared,
    n = n,
    call = cl
  )

  # Step 14: Assign a class so print methods can be added later if desired
  class(result) <- "Linear_Regression_Model"

  # Step 15: If plot = TRUE, show scatterplot with regression line
  if (plot) {
    plot(x, y,
         main = "Linear Regression Model",
         xlab = "Predictor (x)",
         ylab = "Outcome (y)",
         pch = 19, col = "cyan")
    abline(intercept, slope, col = "purple", lwd = 2)
    legend("topleft",
           legend = c("Data points", "Fitted line"),
           col = c("cyan", "purple"),
           pch = c(19, NA),
           lty = c(NA, 1),
           lwd = c(NA, 2))
  }

  # Step 16: Return the result
  return(result)
}
