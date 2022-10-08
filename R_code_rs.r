# R code for ecosystem monitoring using remote sensing technique

# To fully use the potential of satellite images we need an extra package that may be not already installed in your R
# raster is the package to manage image data

# If you already have raster installed skip this line of code
# install.packages("raster")

library(raster)

# Set the working directory, choose you operating system
# setwd("~/lab/") # Linux 
setwd("C:/lab/")  # windows
# setwd("/Users/name/lab/") # mac

# to import the data we use the brick function.
# with brick we are going to create a raster brick which is more or less the data cube conteining all our bands.
l2011 <-  brick("p224r63_2011.grd")
l1988 <-  brick("p224r63_1988.grd")

l2011

class      : RasterBrick 
dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
resolution : 30, 30  (x, y)
extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
source     : p224r63_2011.grd 
names      :      B1_sre,      B2_sre,      B3_sre,      B4_sre,      B5_sre,       B6_bt,      B7_sre 
min values :         0.0,         0.0,         0.0,         0.0,         0.0,       295.1,         0.0 
max values :   1.0000000,   0.2563655,   0.2591587,   0.5592193,   0.4894984, 305.2000000,   0.3692634 
























