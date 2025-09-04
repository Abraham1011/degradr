library(degradr)
library(dplyr)
test_that("fit_healthindex returns healthindex object", {
  data <- train_FD001 %>%
    select(unit,t,T24,T50,P30,
           Nf,Ps30,phi, NRf,
           BPR,htBleed,
           W31, W32) %>%
    mutate(across(c(P30,phi,W31,W32), ~ . * -1))
  hi <- fit_healthindex(data)
  expect_s3_class(hi, "healthindex")
  expect_true(all(c("index", "model") %in% names(hi)))
})
