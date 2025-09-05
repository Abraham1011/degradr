RLD <- function(t, n, u1, sigma1, sigma2, p,D){
  gt <- g2(t = t, n = n, u1 = u1, sigma1 = sigma1,
           sigma2 = sigma2, p = p, D = D)
  g0 <-  g2(t = 0, n = n, u1 = u1, sigma1 = sigma1,
            sigma2 = sigma2, p = p, D = D)
  value <- (pnorm(g0) - pnorm(gt))/(pnorm(g0))
  return(value)
}
