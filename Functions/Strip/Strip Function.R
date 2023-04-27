Strip <- function(variable_name,dataset,hr_vector){
  variable <- vector("list",length(dataset))
  hr_DF <- vector("list",length(dataset))
  hr_PF <- vector("list",length(dataset))

  for (i in seq(dataset)){
    variable_name <- (substitute(variable_name))
    variable[[i]] <- dataset[[i]]$final.year.outputs$NetworkIndexResults[variable_name,]
    #hr_DF[[(x-1)*length(hr_vector)+i]] <- hr_vector[i]
    #hr_PF[[(x-1)*length(hr_vector)+i]] <- hr_vector[x]
  }
  
  #combine variable into a df with corresponding HR
  variable = do.call(rbind,variable)
  #hr_DF = do.call(rbind,hr_DF)
  #hr_PF = do.call(rbind,hr_PF)
  #variable <- data.frame(hr_PF,hr_DF,variable)
  
  return(variable)
}