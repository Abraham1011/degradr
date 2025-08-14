compute_healthindex <- function(model,data){
  w <- model$index$w
  phi <- model$index$phi
  type = model$model$type
  if(type == "exponential"){
    data_index <- log_transform(data = data, phi_list = phi)
  }else{
    data_index <- data
  }
  index <- data_index %>%
    mutate(x = as.vector(as.matrix(select(.,-unit,-t)) %*% w)) %>%
    select(unit,t,x)
  return(index)
}
