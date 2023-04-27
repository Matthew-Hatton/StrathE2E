library(metR)
library(StrathE2EPolar)
library(ggplot2)


setwd("C:\\Users\\psb22188\\AppData\\Local\\R\\win-library\\4.2\\StrathE2EPolar\\extdata\\Models")
base_mult <- read.csv("Barents_Sea_gearmult\\2011-2019\\Param\\fishing_gear_multiplier.csv",header = TRUE) #import base HR multiplier csv file

mult <- seq(0,8,2) #Defines Gear multipliers
BS_2010 <- vector("list",length(mult))

for (x in seq(mult)) {
  base_mult$Multiplier_to_be_applied_to_activity <- mult[x]  # sets all multipliers
  write.csv(base_mult,file = "Barents_Sea_gearmult\\2011-2019\\Param\\fishing_gear_multiplier.csv",row.names = FALSE) #writes new file
  
  print(paste("Finding Steady State ",x," / ",length(mult),sep = "")) #add out of value here
  model_read <- e2ep_read("Barents_Sea_gearmult","2011-2019",results.path = "Barents_Sea_gearmult\\2011-2019\\Results",quiet = TRUE)
  model_run <- e2ep_run(model = model_read,nyears = 50) #obtain s.s
  print("Extracting Start")
  e2ep_extract_start(model = model_read,results = model_run,csv.output = TRUE) # saves IC to results
  print("done this")
  file.rename("Barents_Sea_gearmult\\2011-2019\\Results\\Barents_Sea_gearmult\\2011-2019\\initial_values-base.csv","Barents_Sea_gearmult\\2011-2019\\Param\\initial_values_BS_2011-2019.csv")
  
  print("Steady State found, running model")
  model_read <- e2ep_read("Barents_Sea_gearmult","2011-2019",results.path = "Barents_Sea_gearmult\\2011-2019\\Results",quiet = TRUE) #reads model= model_read, nyears = 1,quiet = TRUE))
  BS_2010[[x]] <- e2ep_run(model = model_read,nyears = 10)
  
}
rm(model_run,model_read,base_mult,mult,x)
#e2e_copy(model.name = "Celtic_Sea",model.variant = "2003-2013",source.path = NULL,dest.path = "")

