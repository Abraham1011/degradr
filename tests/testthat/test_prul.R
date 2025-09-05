library(degradr)

set.seed(123)

test_that("prul returns expected columns", {
  colnames(filter_train) <- c("t", "x", "unit")
  colnames(filter_test)  <- c("t", "x", "unit", "RUL")
  model <- fit_model(data = filter_train, type = "exponential", degree = 1)
  prob <- prul(t = 50, data = filter_test, model = model, D = 600)
  expect_true(all(c("unit", "PRUL") %in% colnames(prob)))
})
