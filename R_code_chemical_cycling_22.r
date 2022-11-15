# R code for chemical cycling anlysis

# First of all, set the working directory
setwd('C:/lab/EN/')

# Then load the packages needed for the analysis or in case install them with install.packages() and then load them
library(raster)

###############
# Data Import #
###############

# this time we will use raster() function (not brick()) because we are dealing with single layers
# first we import all the images with the boring method repeting for all the images the raster function
EN01 <- raster("EN_0001.png")
EN02 <- raster("EN_0002.png")
EN03 <- raster("EN_0003.png")
EN04 <- raster("EN_0004.png")
EN05 <- raster("EN_0005.png")
EN06 <- raster("EN_0006.png")
EN07 <- raster("EN_0007.png")
EN08 <- raster("EN_0008.png")
EN09 <- raster("EN_0009.png")
EN10 <- raster("EN_0010.png")
EN11 <- raster("EN_0011.png")
EN12 <- raster("EN_0012.png")
EN13 <- raster("EN_0013.png")

EN01

# class      : RasterLayer 
# band       : 1  (of  3  bands)
# dimensions : 432, 768, 331776  (nrow, ncol, ncell)
# resolution : 1, 1  (x, y)
# extent     : 0, 768, 0, 432  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : EN_0001.png 
# names      : layer  

# In this part of the code I will set all the color Ramp Palette I need
cl <- colorRampPalette(c('red', 'orange', 'yellow')) (100)

# plot the NO2 values 
plot(EN01, col=cl)
plot(EN13, col=cl)

# With par() I will create a multiframe
par(mfrow=c(2, 1))
plot(EN01, col=cl)
plot(EN13, col=cl)

# this is another multiframe but with all the images
par(mfrow=c(4,4))
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)

# to avoid this boring and awfull method we have to create a STACK!
# the magic function is stack()
EN <- stack(EN01, EN02, EN03, EN04, EN05, EN06, EN07, EN08, EN09, EN10, EN11, EN12, EN13)

# now that the stack is ready we can plot it easily
plot(EN, col=cl)

# to plot only the first image of the stack we have to use the $
EN
# class      : RasterStack 
# dimensions : 432, 768, 331776, 13  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 768, 0, 432  (xmin, xmax, ymin, ymax)
# crs        : NA 
# names      : layer.1, layer.2, layer.3, layer.4, layer.5, layer.6, layer.7, layer.8, layer.9, layer.10, layer.11, layer.12, layer.13 

plot(EN$layer.1, col=cl)

plotRGB(EN, r=1,  g=7, b=13, stretch='Lin')

# the next step is to use lapply function!! 

# first of all let's built the list with the list.file function
# as we have already set the working directory we can ignore the path argument of the function
enlist <- list.files(pattern='EN')

# now that the list is ready let's use lapply to apply raster function to the list of files
EN <- lapply(enlist, raster)
EN

# EN is just a list to use it for the analysis we need a rasterStack. Let's use the stack() fucntion
EN_stack <- stack(EN)

plot(EN_stack, col = cl)

# Excercise: plot only the first image of the stack

plot(EN_stack$layer.1, col = cl)

# another operations that we can do is calculate the differance between 2 moment

EN_diff <- (EN_stack$layer.1 - EN_stack$layer.13)
cl_new <- colorRampPalette(c('blue', 'white', 'red')) (100)

plot(EN_diff, col = cl_new)

###!!!### IMPORTANT ###!!!###

# now we learn how to to process and entire code (that someone else have written) without copy-paste it
# we wil use the source() funciton!!!

source('R_code_automatic_script.r')
