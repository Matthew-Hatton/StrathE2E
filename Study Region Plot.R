#clears memory
rm(list=ls())
library(ncdf4)
library(tidyverse)
library(ggplot2)
library(raster)
library(naniar)
theme_set(theme_minimal())

#route of file we want to open
fn <- "C:\\Users\\psb22188\\Documents\\PhD\\22-23\\NEMO\\NEMO DATA\\grid_T_19800105.nc"

#opens netCDF file
nc <- nc_open(fn)

#Extracts latitude and longitude matrices into variables
nav_lat <- ncvar_get(nc,"nav_lat")
nav_long <- ncvar_get(nc,"nav_lon")

#Extracts depth levels
depth <- ncvar_get(nc,"deptht")

#Extracts Temperature
votemper <- ncvar_get(nc,"votemper")

#Extracts Salinity
vosaline <- ncvar_get(nc,"vosaline")

#Extracts sea surface height
sossheig <- ncvar_get(nc,"sossheig")

#Extracts ice fraction
soicecov <- ncvar_get(nc,"soicecov")

#Close ncdf file to avoid memory loss
nc_close(nc)
#need to change colours as to not wash out detail

Foo <- reshape2::melt(votemper[940:1009,151:323,1])

Foo$value <- replace(Foo$value, Foo$value > 10000, NaN)
Foo$value <- replace(Foo$value, Foo$value == 0, NaN)

mid <- (max(Foo$value,na.rm=TRUE)+min(Foo$value,na.rm = TRUE))/2

#plots
sp <- ggplot(data=Foo) + geom_raster(aes(x=Var1,y=Var2,fill=value)) + labs(x=NULL,y=NULL,fill="Temperature (Degrees)")
sp + scale_fill_gradient2(midpoint = mid, low = "darkblue", mid = "lightblue",
                              high = "red", space = "Lab",na.value="black") + scale_x_discrete(labels = NULL, breaks =NULL) +
                              scale_y_discrete(labels = NULL, breaks =NULL) + ggtitle("Water Temperature at 0.5m")
