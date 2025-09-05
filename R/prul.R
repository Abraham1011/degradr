
prul <- function(t,data,model,D = NULL){
  if (inherits(model, "healthindex")) {
    data_index <- log_transform(data = data, phi_list = model$index$phi)
    data <- data_index %>%
      mutate(x = as.vector(as.matrix(select(.,-unit,-t)) %*% model$index$w)) %>%
      select(unit,t,x)
    model <- model$model
  }
  tt <- data$t
  x <- data$x
  n <- max(tt)
  post <- posterior(model = model, t = tt, x = x)
  u1 <- post$u1
  sigma1 <- post$sigma1
  sigma2 <- model$sigma2
  ud <- model$ud
  vd <- model$vd
  p <- model$degree
  if(class(model) == "healthindex"){
    type = model$model$type
  }else{
    type <- model$type
  }

  if(type == "exponential"){
    if(is.null(D)){
      value <- RLD_random(t = t, n = n, u1 = u1, sigma1 = sigma1,
                 sigma2 = sigma2, ud = ud, vd = vd, p = p)
    }else{
      phi <- model$phi
      D_trans <- log(D - phi)
      value <- RLD(t = t, n = n, u1 = u1,
                      sigma1 = sigma1, sigma2 = sigma2,
                      p = p,D = D_trans)
    }
  }else{
    if(is.null(D)){
      value <- RLD_random(t = t, n = n, u1 = u1, sigma1 = sigma1,
                 sigma2 = sigma2, ud = ud, vd = vd, p = p)
    }else{
      value <- RLD(t = t, n = n, u1 = u1,
                   sigma1 = sigma1, sigma2 = sigma2,
                   p = p,D = D)
    }
  }
  return(value)
}

