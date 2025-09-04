library(degradr)

set.seed(123)

test_that("predict_rul returns expected columns", {
  data <- data.frame(
    unit = rep(1:2, each = 3),
    t = rep(1:3, 2),
    x = c(2, 3, 4, 2, 3, 4)
  )
  model <- fit_model(data)
  preds <- predict_rul(data, model)
  expect_s3_class(preds, "data.frame")
  expect_true(all(c("unit", "RUL") %in% colnames(preds)))
})
