############## Calculate Robustness with any alpha ##################
robustness <- function(alpha){
  robust <- -alpha*log(alpha)
  return(robust)
}
###########################################################################



