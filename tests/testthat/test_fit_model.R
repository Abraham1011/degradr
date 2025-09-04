library(degradr)

set.seed(123)

test_that("fit_model returns degradation_model", {
  colnames(filter_train) <- c("t", "x", "unit")
  model <- fit_model(filter_train)
  expect_s3_class(model, "degradation_model")
  expect_true(all(c("u0", "Sigma0", "sigma2", "phi") %in% names(model)))
})
