library(metR)
library(StrathE2E2)
library(ggplot2)


setwd("C:\\Users\\psb22188\\AppData\\Local\\R\\win-library\\4.2\\StrathE2E2_runs\\extdata\\Models")
base_mult <- read.csv("North_Sea\\2003-2013\\Param\\fishing_gear_multiplier.csv",header = TRUE) #import base HR multiplier csv file

mult <- seq(0,8,1) #Defines Gear multipliers
NS_2010 <- vector("list",length(mult))

for (x in seq(mult)) {
  print(paste("Finding Steady State ",x," / ",length(mult),sep = ""))
  model_read <- e2e_read("North_Sea","2003-2013",results.path = "North_Sea\\2003-2013\\Results",quiet = TRUE)
  model_read$data$fleet.model$gear_mult = mult[x] #change gear mult
  print(model_read$data$fleet.model$gear_mult) #check multipliers
  model_run <- e2e_run(model = model_read,nyears = 100)
  e2e_plot_ts(model = model_read,results = model_run)#Check if we have reached a s.s
  print("Extracting Start")
  e2e_extract_start(model = model_read,results = model_run,csv.output = TRUE) # saves IC to results
  print("done this")
  file.rename("North_Sea\\2003-2013\\Results\\North_Sea\\2003-2013\\initial_values-base.csv","North_Sea\\2003-2013\\Param\\initial_values_NORTH_SEA_2003-2013.csv")
  
  print("Steady State found, running model")
  model_read <- e2e_read("North_Sea","2003-2013",results.path = "North_Sea\\2003-2013\\Results",quiet = TRUE) #reads model= model_read, nyears = 1,quiet = TRUE))
  model_read$data$fleet.model$gear_mult = mult[x] #change gear mult
  NS_2010[[x]] <- e2e_run(model = model_read,nyears = 10) #run model and store result
  
}
rm(model_run,model_read,base_mult,mult,x)
#e2e_copy(model.name = "Celtic_Sea",model.variant = "2003-2013",source.path = NULL,dest.path = "")

#check values
NS_con <- seq(0,8,1)
for (i in seq(NS_2010)){
  NS_con[i] <- NS_2010[[i]]$final.year.outputs$NetworkIndexResults['Effective_connectance_CZ',]
}
