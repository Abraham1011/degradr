model_nlme <- function(fixed_formula,random_formula,data){
  model <- nlme::lme(
    fixed = fixed_formula,
    random = random_formula,
    data = data
  )
  u0 <- fixed.effects(model)
  Sigma0 <- getVarCov(model)
  sigma2 <- sigma(model)^2
  return(list(model = model, u0 = u0, Sigma0 = Sigma0,
              sigma2 = sigma2))
}

