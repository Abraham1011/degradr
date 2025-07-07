posterior <- function(model,t,x){
  degree <- model$degree
  Sigma0 <- model$Sigma0
  sigma2 <- model$sigma2
  type <- model$type
  u0 <- model$u0
  if(type == "exponential"){
    phi <- model$phi
    df_posterior <- data.frame(t = t, x = x)
    df_posterior <- df_posterior %>%
      mutate(
        L = log(x - phi)
      )
    L <- df_posterior$L
    psi <- design_matrix(t,degree = degree)
    term1 <- solve((t(psi)%*%psi)/sigma2+solve(Sigma0))
    term2 <- (t(psi)%*%L)/sigma2 + solve(Sigma0)%*%u0
    u1 <- term1%*%term2
    sigma1 <- solve((t(psi)%*%psi)/sigma2 + solve(Sigma0))
  }else{
    df_posterior <- data.frame(t = t, x = x)
    L <- df_posterior$x
    psi <- design_matrix(t,degree = degree)
    term1 <- solve((t(psi)%*%psi)/sigma2+solve(Sigma0))
    term2 <- (t(psi)%*%L)/sigma2 + solve(Sigma0)%*%u0
    u1 <- term1%*%term2
    sigma1 <- solve((t(psi)%*%psi)/sigma2 + solve(Sigma0))
  }

  return(list(u1 = u1, sigma1 = sigma1))
}
