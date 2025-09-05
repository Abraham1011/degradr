prul <- function(t, data, model, D = NULL){
  # Preprocesamiento si es un objeto healthindex (misma lógica que en qrul)
  if (inherits(model, "healthindex")) {
    data_index <- log_transform(data = data, phi_list = model$index$phi)
    data <- data_index %>%
      dplyr::mutate(x = as.vector(as.matrix(dplyr::select(., -unit, -t)) %*% model$index$w)) %>%
      dplyr::select(unit, t, x)
    model <- model$model
  }

  # Validación de columnas
  if (!all(c("t", "x", "unit") %in% colnames(data))) {
    stop("Input data must have columns: 't', 'x', and 'unit'")
  }

  # Split por unidad
  units_list <- split(data, data$unit)

  # Wrappers seguros (evitan que una unidad con error rompa todo)
  safe_RLD <- function(...) {
    tryCatch(RLD(...), error = function(e) NA_real_)
  }
  safe_RLD_random <- function(...) {
    tryCatch(RLD_random(...), error = function(e) NA_real_)
  }

  # Predicción por unidad
  predict_one <- function(unit_data) {
    tt <- unit_data$t
    x  <- unit_data$x
    n  <- max(tt)

    post <- posterior(model = model, t = tt, x = x)
    u1 <- post$u1
    sigma1 <- post$sigma1
    sigma2 <- model$sigma2
    ud <- model$ud
    vd <- model$vd
    p  <- model$degree

    # Tipo de modelo
    type <- if (inherits(model, "healthindex")) model$model$type else model$type

    # Selección de función según D y transformación si es exponencial
    if (is.null(D)) {
      val <- safe_RLD_random(t = t, n = n, u1 = u1, sigma1 = sigma1,
                             sigma2 = sigma2, ud = ud, vd = vd, p = p)
    } else {
      D_trans <- D
      if (type == "exponential") {
        phi <- model$phi
        D_trans <- log(D - phi)
      }
      val <- safe_RLD(t = t, n = n, u1 = u1, sigma1 = sigma1,
                      sigma2 = sigma2, p = p, D = D_trans)
    }

    data.frame(
      unit = unique(unit_data$unit),
      prob = round(val, 4)
    )
  }

  # Ejecutar por unidad y consolidar
  results <- lapply(units_list, predict_one)
  results_df <- dplyr::bind_rows(results)

  return(results_df)
}
