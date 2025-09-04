library(degradr)

set.seed(123)

test_that("fit_model returns degradation_model", {
  data <- data.frame(
    unit = rep(1:2, each = 3),
    t = rep(1:3, 2),
    x = c(2, 3, 4, 2, 3, 4)
  )
  model <- fit_model(data)
  expect_s3_class(model, "degradation_model")
  expect_true(all(c("u0", "Sigma0", "sigma2", "phi") %in% names(model)))
})
