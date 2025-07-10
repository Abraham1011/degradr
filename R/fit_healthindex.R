fit_healthindex <- function(data, type = "exponential", method = "nlme",
                            degree = 2, phi = NULL, r = 0.5){
  index <- healthindex(data = data, type = type,
                       p = degree, r = r, phi = phi)
  w <- index$w
  phi <- index$phi
  if(type == "exponential"){
    data_index <- log_transform(data = data, phi = phi)
  }else{
    data_index <- data
  }
  data_model <- data_index %>%
    mutate(x = as.vector(as.matrix(select(.,-unit,-t)) %*% w)) %>%
    select(unit,t,x)
  model <- fit_model(data = data_model,type = "linear",
                     method = method, degree = degree, phi = NULL)
  structure(list(
    index = index,
    model = model
  ), class = "healthindex")
}

