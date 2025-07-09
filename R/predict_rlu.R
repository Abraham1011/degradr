predict_rlu <- function(data, model, D = NULL, alpha = 0.05, upper = NULL) {
  if (!all(c("t", "x", "unit") %in% colnames(data))) {
    stop("Input data must have columns: 't', 'x', and 'unit'")
  }

  if (is.null(upper)) {
    upper <- model$upper
  }

  units_list <- split(data, data$unit)

  safe_qRLD <- function(q, ...) {
    tryCatch(
      qRLD(q, ...),
      error = function(e) {
       NA
      }
    )
  }

  safe_qRLD_random <- function(q, ...) {
    tryCatch(
      qRLD_random(q, ...),
      error = function(e) {
        NA
      }
    )
  }

  predict_one <- function(unit_data) {
    t <- unit_data$t
    x <- unit_data$x
    n <- max(t)
    post <- posterior(model = model, t = t, x = x)
    u1 <- post$u1
    sigma1 <- post$sigma1
    sigma2 <- model$sigma2
    ud <- model$ud
    vd <- model$vd
    p <- model$degree
    type <- model$type

    if (is.null(D)) {
      li <- safe_qRLD_random(alpha/2, n = n, u1 = u1,
                             sigma1 = sigma1, sigma2 = sigma2,
                             ud = ud, vd = vd, p = p, upper = upper)
      med <- safe_qRLD_random(0.5, n = n, u1 = u1,
                              sigma1 = sigma1, sigma2 = sigma2,
                              ud = ud, vd = vd, p = p, upper = upper)
      ls <- safe_qRLD_random(1 - alpha/2, n = n, u1 = u1,
                             sigma1 = sigma1, sigma2 = sigma2,
                             ud = ud, vd = vd, p = p, upper = upper)
    } else {
      D_trans <- D
      if (type == "exponential") {
        phi <- model$phi
        D_trans <- log(D - phi)
      }

      li <- safe_qRLD(alpha/2, n = n, u1 = u1,
                      sigma1 = sigma1, sigma2 = sigma2,
                      p = p, D = D_trans, upper = upper)
      med <- safe_qRLD(0.5, n = n, u1 = u1,
                       sigma1 = sigma1, sigma2 = sigma2,
                       p = p, D = D_trans, upper = upper)
      ls <- safe_qRLD(1 - alpha/2, n = n, u1 = u1,
                      sigma1 = sigma1, sigma2 = sigma2,
                      p = p, D = D_trans, upper = upper)
    }

    data.frame(
      unit = unique(unit_data$unit),
      RLU_lower = li,
      RLU_median = med,
      RLU_upper = ls
    )
  }

  results <- lapply(units_list, predict_one)
  results_df <- dplyr::bind_rows(results)

  return(results_df)
}

