g2 <- function(t, n, u1, sigma1, sigma2, p,D) {
  z <- (n + t)^(0:p)
  u_tilde <- sum(z * u1)
  sigma2_tilde <- ((t(z) %*% sigma1) %*% z ) + sigma2
  value <- (D - u_tilde)/sqrt(sigma2_tilde)
  return(value)
}
