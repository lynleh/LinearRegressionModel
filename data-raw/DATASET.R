## code to prepare `DATASET` dataset goes here
#Generate a dataset for the linear regression model

set.seed(22)
n = 100
x = seq(0, 20, length.out = n)
y = 3 + 1.2 * x + rnorm(n, sd = 2)
group = rep(c("A", "B"), each = n/2)  # factor for potential extensions
data_linear_regression = data.frame(x = x, y = y, group = group)

# Save into the package as a dataset
usethis::use_data(data_linear_regression, overwrite = TRUE)


