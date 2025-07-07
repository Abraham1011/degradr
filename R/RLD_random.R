RLD_random <- function(t, n, u1, sigma1, sigma2, ud, vd, p) {
  gt <- g(t = t, n = n, u1 = u1, sigma1 = sigma1,
          sigma2 = sigma2, ud = ud, vd = vd, p = p)
  g0 <- g(0, n = n, u1 = u1, sigma1 = sigma1,
          sigma2 = sigma2, ud = ud, vd = vd, p = p)
  value <- (pnorm(gt) - pnorm(g0)) / (1 - pnorm(g0))
  return(value)
}
