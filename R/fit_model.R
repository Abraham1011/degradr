fit_model <- function(data, type = "exponential", method = "lm",
                      degree = 2, phi = NULL) {
  if(type == "exponential"){
    if (is.null(phi)) {
      epsilon <- 0.1
      phi <- min(data$x) - epsilon * diff(range(data$x))
    }
    model_data <- data %>%
      mutate(
        L = log(x - phi)
      )

    data_last <- model_data %>%
      group_by(unit) %>%
      slice_tail(n = 1)
    time_terms <- paste0("I(t^", 1:degree, ")", collapse = " + ")
    fixed_formula <- as.formula(paste("L ~", time_terms))
    random_formula <- as.formula(paste("~", time_terms, "| unit"))

    model <- switch (method,
      "nlme" = model_nlme(
        fixed_formula = fixed_formula,
        random_formula = random_formula,
        data = model_data),
      "lm" = model_lm(
        fixed_formula = fixed_formula,
        data = model_data)
    )

    u0 <- model$u0
    Sigma0 <- model$Sigma0
    sigma2 <- model$sigma2
    ud <- mean(data_last$L)
    vd <- var(data_last$L)
    structure(list(
      model = model,
      u0 = u0,
      Sigma0 = Sigma0,
      sigma2 = sigma2,
      phi = phi,
      type = type,
      degree = degree,
      ud = ud,
      vd = vd,
      upper = max(data$t)
    ), class = "degradation_model")
  }else{
    data_last <- data %>%
      group_by(unit) %>%
      slice_tail(n = 1)
    time_terms <- paste0("I(t^", 1:degree, ")", collapse = " + ")
    fixed_formula <- as.formula(paste("x ~", time_terms))
    random_formula <- as.formula(paste("~", time_terms, "| unit"))

    model <- switch (method,
                     "nlme" = model_nlme(
                       fixed_formula = fixed_formula,
                       random_formula = random_formula,
                       data = data),
                     "lm" = model_lm(
                       fixed_formula = fixed_formula,
                       data = data)
    )

    u0 <- model$u0
    Sigma0 <- model$Sigma0
    sigma2 <- model$sigma2
    ud <- mean(data_last$x)
    vd <- var(data_last$x)
    structure(list(
      model = model$model,
      u0 = u0,
      Sigma0 = Sigma0,
      sigma2 = sigma2,
      type = type,
      degree = degree,
      ud = ud,
      vd = vd,
      upper = max(data$t)
    ), class = "degradation_model")
  }
}
