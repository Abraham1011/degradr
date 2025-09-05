
prul <- function(t, data, model, D = NULL) {
  if (inherits(model, "healthindex")) {
    data_index <- log_transform(data = data, phi_list = model$index$phi)
    data <- data_index %>%
      mutate(x = as.vector(as.matrix(select(., -unit, -t)) %*% model$index$w)) %>%
      select(unit, t, x)
    model <- model$model
  }

  if (!all(c("t", "x", "unit") %in% colnames(data))) {
    stop("Input data must have columns: 't', 'x', and 'unit'")
  }

  units_list <- split(data, data$unit)

  predict_one <- function(unit_data) {
    tt <- unit_data$t
    x <- unit_data$x
    n <- max(tt)
    post <- posterior(model = model, t = tt, x = x)
    u1 <- post$u1
    sigma1 <- post$sigma1
    sigma2 <- model$sigma2
    ud <- model$ud
    vd <- model$vd
    p <- model$degree
    type <- model$type

    if (type == "exponential") {
      if (is.null(D)) {
        value <- RLD_random(t = t, n = n, u1 = u1, sigma1 = sigma1,
                            sigma2 = sigma2, ud = ud, vd = vd, p = p)
      } else {
        phi <- model$phi
        D_trans <- log(D - phi)
        value <- RLD(t = t, n = n, u1 = u1,
                     sigma1 = sigma1, sigma2 = sigma2,
                     p = p, D = D_trans)
      }
    } else {
      if (is.null(D)) {
        value <- RLD_random(t = t, n = n, u1 = u1, sigma1 = sigma1,
                            sigma2 = sigma2, ud = ud, vd = vd, p = p)
      } else {
        value <- RLD(t = t, n = n, u1 = u1,
                     sigma1 = sigma1, sigma2 = sigma2,
                     p = p, D = D)
      }
    }

    data.frame(
      unit = unique(unit_data$unit),
      PRUL = value
    )
  }

  results <- lapply(units_list, predict_one)
  results_df <- dplyr::bind_rows(results)

  return(results_df)
}

