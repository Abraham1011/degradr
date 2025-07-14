compute_phi <- function(data, epsilon = 0.1) {
  vars <- setdiff(names(data), c("unit", "t"))
  phi_list <- lapply(data[vars], function(x) min(x) - epsilon * diff(range(x)))
  names(phi_list) <- vars
  return(phi_list)
}
