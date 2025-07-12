plot_degradr <- function(data,D = NULL){
  g <- ggplot(data = data) +
     geom_line(aes(x = t, y = x, group = unit))
  if(!is.null(D)){
    g <- g +
      geom_hline(yintercept = D, col = "red")
  }
  return(g)
}

