log_transform <- function(data, phi_list, exclude = c("unit", "t")) {
  df_trans <- data
  for (var in names(phi_list)) {
    if (!var %in% names(data)) {
      stop(paste("Variable", var, "not found in the new dataset.."))
    }
    df_trans[[var]] <- log(data[[var]] - phi_list[[var]])
  }
  return(df_trans)
}
