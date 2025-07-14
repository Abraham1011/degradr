model_lm <- function(fixed_formula, data) {
  unidades <- unique(data$unit)
  coef_list <- list()
  sigma2_list <- numeric(length(unidades))

  for (i in seq_along(unidades)) {
    df_u <- subset(data, unit == unidades[i])
    model_u <- lm(fixed_formula, data = df_u)

    # Guardar coeficientes
    coef_list[[i]] <- coef(model_u)

    # MSE residual para la unidad i
    sigma2_list[i] <- mean(residuals(model_u)^2)
  }

  coef_mat <- do.call(rbind, coef_list)

  u0 <- colMeans(coef_mat)
  Sigma0 <- cov(coef_mat)
  sigma2 <- mean(sigma2_list)  # Promedio de los MSE por unidad

  return(list(
    u0 = u0,
    Sigma0 = Sigma0,
    sigma2 = sigma2
  ))
}
