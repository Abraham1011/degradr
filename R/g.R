g <- function(t, n, u1, sigma1, sigma2, ud, vd, p) {
  z <- (n + t)^(0:p)
  u_tilde <- sum(z * u1)
  sigma2_tilde <- ((t(z) %*% sigma1) %*% z ) + sigma2
  g <- (u_tilde - ud) / sqrt(sigma2_tilde + vd)
  return(g)
}
