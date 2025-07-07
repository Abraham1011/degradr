qRLD <- function(q, n, u1, sigma1, sigma2,
                 p, D, lower = 0, upper) {
  obj <- function(t) q - RLD(t = t, n = n, u1 = u1,
                             sigma1 = sigma1,sigma2 = sigma2,
                             D = D, p = p)
  uniroot(obj, lower = lower, upper = upper)$root
}
qRLD <- Vectorize(qRLD, vectorize.args = "q")
