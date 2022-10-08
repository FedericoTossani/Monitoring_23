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

#class      : RasterBrick 
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
#source     : p224r63_2011.grd 
#names      :      B1_sre,      B2_sre,      B3_sre,      B4_sre,      B5_sre,       B6_bt,      B7_sre 
#min values :         0.0,         0.0,         0.0,         0.0,         0.0,       295.1,         0.0 
#max values :   1.0000000,   0.2563655,   0.2591587,   0.5592193,   0.4894984, 305.2000000,   0.3692634 


#plot() is the function to use to plot our data
plot(l2011)

#each band is corresponding to a different part of the spectrum
#the first 3 bands are the blue, green and red light. this cover the visible part of the spectrum

#in a plot R is using a standard color palette, if you want to modify it the right function is colorRampPalette

cl <- colorRampPalette(c("black", "grey", "light grey"))(100)

#plotRGB is another funciton to plot images, what makes it special is the possibility to set which band have to stay in the different part of the RGB scheme
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin") 

# b1 = reflectance in the blue
# b2 = reflectance in the green
# b3 = reflectance in the red
# b4 = reflectance in the NIR (Near Infrared)

# with the $ we are linking a part of the image to the name so we are able to plot only that part.
# in our case we are trying to plot only the green band of our rasterbrick file
plot(l2011$B2_sre)

cl <- colorRampPalette(c("black", "dark grey", "grey", "light grey"))(100)

# plot function have different argument, one of them is col =. with col can assign a new color palette to the plot
plot(l2011$B2_sre, col = clb)

# I can create every color palette i want, such as this one that goes from black to light green
clg <- colorRampPalette(c("black", "green", "light green"))(100)
plot(l2011$B2_sre, col = clg)

# let's do the same with the blue band
clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(l2011$B1_sre, col = clb)

# par() is a function that allows us to plot one graph beside of the other
# mf stay for multiframe

par(mfrow=c(1,2))
plot(l2011$B1_sre, col = clb)
plot(l2011$B2_sre, col = clg)

# now we'll do the same but with 2 rows and 1 column

par(mfrow=c(2,1))
plot(l2011$B1_sre, col = clb)
plot(l2011$B2_sre, col = clg)

# is the function to shut down the device (the graph in our case)
# dev.off()

















