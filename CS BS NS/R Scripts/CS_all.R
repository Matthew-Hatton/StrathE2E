library(metR)
library(StrathE2E2)
library(ggplot2)


setwd("C:\\Users\\psb22188\\AppData\\Local\\R\\win-library\\4.2\\StrathE2E2_runs\\extdata\\Models\\Models")
base_mult <- read.csv("Celtic_Sea\\2003-2013\\Param\\fishing_gear_multiplier.csv",header = TRUE) #import base HR multiplier csv file

mult <- seq(0,8,2) #Defines Gear multipliers
CS_2010 <- vector("list",length(mult))

for (x in seq(mult)) {
    base_mult$Multiplier_to_be_applied_to_activity <- mult[x]  # sets all multipliers
    write.csv(base_mult,file = "Celtic_Sea\\2003-2013\\Param\\fishing_gear_multiplier.csv",row.names = FALSE) #writes new file
    
    print(paste("Finding Steady State ",x," / ",length(mult),sep = "")) #add out of value here
    model_read <- e2e_read("Celtic_Sea","2003-2013",results.path = "Celtic_Sea\\2003-2013\\Results",quiet = TRUE)
    model_run <- e2e_run(model = model_read,nyears = 50) #obtain s.s
    print("Extracting Start")
    e2e_extract_start(model = model_read,results = model_run,csv.output = TRUE) # saves IC to results
    print("done this")
    file.rename("Celtic_Sea\\2003-2013\\Results\\Celtic_Sea\\2003-2013\\initial_values-base.csv","Celtic_Sea\\2003-2013\\Param\\initial_values_CELTIC_SEA_2003-2013.csv")
    
    print("Steady State found, running model")
    model_read <- e2e_read("Celtic_Sea","2003-2013",results.path = "Celtic_Sea\\2003-2013\\Results",quiet = TRUE) #reads model= model_read, nyears = 1,quiet = TRUE))
    CS_2010[[x]] <- e2e_run(model = model_read,nyears = 10)

}
rm(model_run,model_read,base_mult,mult,x)
#e2e_copy(model.name = "Celtic_Sea",model.variant = "2003-2013",source.path = NULL,dest.path = "")

