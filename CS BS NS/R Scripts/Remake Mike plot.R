library(ggplot2)

#plot
setwd("C:\\Users\\psb22188\\Documents\\PhD\\22-23\\StrathE2E\\Polar\\Experiments\\CS BS NS")

#Extract Effective Connectance
BS_con <- seq(0,8,1)
for (i in seq(BS_2010)){
  BS_con[i] <- BS_2010[[i]]$final.year.outputs$NetworkIndexResults['Effective_connectance_CZ',]
}

NS_con <- seq(0,8,1)
for (i in seq(NS_con)){
  NS_con[i] <- NS_2010[[i]]$final.year.outputs$NetworkIndexResults['Effective_connectance_CZ',]
}

CS_con <- seq(0,8,1)
for (i in seq(CS_2010)){
  CS_con[i] <- CS_2010[[i]]$final.year.outputs$NetworkIndexResults['Effective_connectance_CZ',]
}

#Extract Phytoplankton f-ratio
NS_fratio <- seq(0,8,1)
for (i in seq(NS_fratio)){
  NS_fratio[i] <- NS_2010[[i]]$final.year.outputs$annual_flux_results_wholedomain[40,1]
}
BS_fratio <- seq(0,8,1)
for (i in seq(BS_fratio)){
  BS_fratio[i] <- BS_2010[[i]]$final.year.outputs$annual_flux_results_wholedomain[43,1]
}
CS_fratio <- seq(0,8,1)
for (i in seq(CS_fratio)){
  CS_fratio[i] <- CS_2010[[i]]$final.year.outputs$annual_flux_results_wholedomain[40,1]
}

NS2010 <- data.frame(NS_con,NS_fratio)
BS2010 <- data.frame(BS_con,BS_fratio)
CS2010 <- data.frame(CS_con,CS_fratio)


#recreate Mike plot
ggplot() +
  geom_point(data = NS2010,aes(x = NS_fratio,y = NS_con),size = 1) +
  geom_point(data = NS2010,aes(x = NS_fratio[1],y = NS_con[1]),colour = "red",size = 5,shape = 21) +
  geom_point(data = NS2010,aes(x = NS_fratio[2],y = NS_con[2]),colour = "blue",size = 5,shape = 21) +
  geom_point(data = NS2010,aes(x = NS_fratio[9],y = NS_con[9]),colour = "green",size = 5,shape = 21) +
  geom_point(data = CS2010,aes(x = CS_fratio,y = CS_con),size = 1) +
  geom_point(data = CS2010,aes(x = CS_fratio[1],y = CS_con[1]),colour = "red",size = 5,shape = 21) +
  geom_point(data = CS2010,aes(x = CS_fratio[2],y = CS_con[2]),colour = "blue",size = 5,shape = 21) +
  geom_point(data = CS2010,aes(x = CS_fratio[9],y = CS_con[9]),colour = "green",size = 5,shape = 21) +
  labs(x = "Phytoplankton f-ratio",y = "Effective Connectance") +
  #xlim(c(0.780,0.810)) +
  #ylim(c(1.75,1.9)) +
  geom_point(data = BS2010,aes(x = BS_fratio,y = BS_con),size = 1) +
  geom_point(data = BS2010,aes(x = BS_fratio[1],y = BS_con[1]),colour = "red",size = 3,shape = 21) +
  geom_point(data = BS2010,aes(x = BS_fratio[2],y = BS_con[2]),colour = "blue",size = 3,shape = 21) +
  geom_point(data = BS2010,aes(x = BS_fratio[9],y = BS_con[9]),colour = "green",size = 3,shape = 21) +
  NULL
#ggsave('NSCSBS2010 fratio against eff con.png',width = 8,height = 4,dpi = 300)
