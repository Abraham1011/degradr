library(degradr)

set.seed(123)

test_that("predict_rul returns expected columns", {
  colnames(filter_train) <- c("t", "x", "unit")
  colnames(filter_test)  <- c("t", "x", "unit", "RUL")
  model <- fit_model(data = filter_train, type = "exponential", degree = 1)
  pred <- predict_rul(data = filter_test, model = model, D = 600)
  expect_true(all(c("unit", "RUL") %in% colnames(pred)))
})
