healthindex <- function(data, type, p, r, phi){
  if(type == "exponential"){
    if(is.null(phi)){
      phi <- compute_phi(data = data)
    }
    df_trans <- log_transform(data = data, phi_list = phi)
    Y <- df_trans %>%
      group_by(unit) %>%
      slice_tail(n = 1) %>%
      ungroup() %>%
      select(-unit, -t)
    Y <- as.matrix(Y)
    m <- length(unique(data$unit))
    s <- dim(Y)[2]
    P_list <- list()
    B_list <- list()
    for(i in 1:m){
      data_unit <- df_trans %>%
        filter(unit == i)
      L <- data_unit %>%
        select(-unit,-t)
      L <- as.matrix(L)
      ti <- data_unit$t
      ni <- length(ti)
      c1 <- 0.9/ni
      ci <- c1 + (ti-1)*(2-2*c1*ni)/((ni-1)*ni)
      ci <- diag(ci)
      Psi <- design_matrix(t = ti, degree = p)
      H <- ci%*%Psi%*%solve(t(Psi)%*%(ci^2)%*%Psi)%*%t(Psi)%*%ci
      I <- diag(ni)
      Pi <- t(L)%*%(I - H)%*%ci%*%L
      P_list[[i]] <- Pi
      B_list[[i]] <- I
    }
    P <- do.call(cbind, P_list)
    B_list <- lapply(P_list, function(Pi) diag(ncol(Pi)))
    B <- do.call(rbind, B_list)
    O <- matrix(1, nrow = m, ncol = m)
    D <- (diag(m) - O/m)/(m-1)
    A <- (1 - r)*P%*%B/m + r*t(Y)%*%D%*%Y
    M <- diag(s)
  }else{
    #phi <- NULL
    df_trans <- data
    Y <- df_trans %>%
      group_by(unit) %>%
      slice_tail(n = 1) %>%
      ungroup() %>%
      select(-unit, -t)
    Y <- as.matrix(Y)
    m <- length(unique(data$unit))
    s <- dim(Y)[2]
    P_list <- list()
    B_list <- list()
    for(i in 1:m){
      data_unit <- df_trans %>%
        filter(unit == i)
      L <- data_unit %>%
        select(-unit,-t)
      L <- as.matrix(L)
      ti <- data_unit$t
      ni <- length(ti)
      c1 <- 0.9/ni
      ci <- c1 + (ti-1)*(2-2*c1*ni)/((ni-1)*ni)
      ci <- diag(ci)
      Psi <- design_matrix(t = ti, degree = p)
      H <- ci%*%Psi%*%solve(t(Psi)%*%(ci^2)%*%Psi)%*%t(Psi)%*%ci
      I <- diag(ni)
      Pi <- t(L)%*%(I - H)%*%ci%*%L
      P_list[[i]] <- Pi
      B_list[[i]] <- I
    }
    P <- do.call(cbind, P_list)
    B_list <- lapply(P_list, function(Pi) diag(ncol(Pi)))
    B <- do.call(rbind, B_list)
    O <- matrix(1, nrow = m, ncol = m)
    D <- (diag(m) - O/m)/(m-1)
    A <- (1 - r)*P%*%B/m + r*t(Y)%*%D%*%Y
    M <- diag(s)
  }

  Dmat <- A
  dvec <- rep(0, s)

  a1 <- t(M) %*% rep(1, s)
  Aeq <- matrix(a1, ncol = 1)

  Aineq <- -M
  bineq <- -rep(1, s)

  Amat <- cbind(Aeq, Aineq)
  bvec <- c(1, bineq)
  meq <- 1

  sol <- solve.QP(Dmat = Dmat, dvec = dvec,
                  Amat = Amat,
                  bvec = bvec,
                  meq = meq)
  w <- sol$solution
  structure(list(
    w = w,
    phi = phi,
    data = data
  ), class = "healthindex")
}





