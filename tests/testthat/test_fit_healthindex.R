library(degradr)

set.seed(123)

test_that("fit_healthindex returns healthindex object", {
  data <- data.frame(
    unit = rep(1:2, each = 3),
    t = rep(1:3, 2),
    s1 = c(2, 3, 4, 2, 3, 4)
  )
  hi <- fit_healthindex(data)
  expect_s3_class(hi, "healthindex")
  expect_true(all(c("index", "model") %in% names(hi)))
})
