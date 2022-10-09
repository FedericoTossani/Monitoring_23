# R code for estimating energy in ecosystem

# this ae the packages you need to run this code. If you don't have this packages installed use the function install.packages()
library(raster)

setwd("C:/lab/")

# Data Import #

l1992 <- brick("defor1_.jpg") # Landsat image of the 1992

l1992

#class      : RasterBrick 
#dimensions : 478, 714, 341292, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : defor1_.jpg 
#names      : defor1__1, defor1__2, defor1__3 



