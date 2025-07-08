fit_model <- function(data, type = "exponential",
                      degree = 2, phi = NULL) {
  if(type == "exponential"){
    if (is.null(phi)) {
      epsilon <- 0.01
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

    model <- nlme::lme(
      fixed = fixed_formula,
      random = random_formula,
      data = model_data
    )
    u0 <- fixed.effects(model)
    Sigma0 <- getVarCov(model)
    sigma2 <- sigma(model)^2
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
      upper = max(data$t),
      logLik = as.numeric(logLik(model)),
      AIC = AIC(model),
      BIC = BIC(model)
    ), class = "degradation_model")
  }else{
    data_last <- data %>%
      group_by(unit) %>%
      slice_tail(n = 1)
    time_terms <- paste0("I(t^", 1:degree, ")", collapse = " + ")
    fixed_formula <- as.formula(paste("x ~", time_terms))
    random_formula <- as.formula(paste("~", time_terms, "| unit"))

    model <- nlme::lme(
      fixed = fixed_formula,
      random = random_formula,
      data = data
    )
    u0 <- fixed.effects(model)
    Sigma0 <- getVarCov(model)
    sigma2 <- sigma(model)^2
    ud <- mean(data_last$x)
    vd <- var(data_last$x)
    structure(list(
      model = model,
      u0 = u0,
      Sigma0 = Sigma0,
      sigma2 = sigma2,
      type = type,
      degree = degree,
      ud = ud,
      vd = vd,
      upper = max(data$t),
      logLik = as.numeric(logLik(model)),
      AIC = AIC(model),
      BIC = BIC(model)
    ), class = "degradation_model")
  }
}
