library(testthat)
source("../functions/lasso_mse.R")

context("Test for lasso_mse")
test_that ("lasso_mse works as expected", {
  x <- 0.01747528
  
  expect_equal(lasso_mse(x), 0.1811564-3.34e-08)
  expect_length(lasso_mse(x), 1)
  expect_type(lasso_mse(x), 'double')
})

source("../functions/plsr_mse.R")

context("Test for lasso_mse")
test_that ("plsr_mse works as expected", {
  x <- 3
  
  expect_equal(plsr_mse(x), 0.1864991-3.45e-08)
  expect_length(plsr_mse(x), 1)
  expect_type(plsr_mse(x), 'double')
})
