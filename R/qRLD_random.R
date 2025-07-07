qRLD_random <- function(q, n, u1, sigma1,sigma2, ud,
                        vd, p, lower = 0, upper) {
  obj <- function(t) q - RLD_random(t = t, n = n, u1 = u1,
                                    sigma1 = sigma1,sigma2 = sigma2,
                                    ud = ud, vd = vd, p = p)
  uniroot(obj, lower = lower, upper = upper)$root
}
qRLD_random <- Vectorize(qRLD_random, vectorize.args = "q")
