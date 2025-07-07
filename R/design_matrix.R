design_matrix <- function(t, degree) {
  n <- length(t)
  Psi <- matrix(nrow = n, ncol = degree + 1)
  for (k in 0:degree) {
    Psi[, k + 1] <- t^k
  }
  return(Psi)
}
