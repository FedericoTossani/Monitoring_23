# R code for estimating energy in ecosystem

# this ae the packages you need to run this code. If you don't have this packages installed use the function install.packages()
library(raster)
library(rgdal)

setwd("C:/lab/")

###############
# Data Import #
###############

l1992 <- brick("defor1_.jpg") # Landsat image of the 1992
l2006 <- brick("defor2_.jpg") # Landsat image of the 2006

l1992

# class      : RasterBrick 
# dimensions : 478, 714, 341292, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : defor1_.jpg 
# names      : defor1__1, defor1__2, defor1__3 

# defor1__1 = NIR
# defor1__2 = red
# defor1__3 = green

plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l1992, r=3, g=2, b=1, stretch="Lin")
plotRGB(l1992, r=3, g=2, b=1, stretch="Lin")

l2006

# class      : RasterBrick 
# dimensions : 478, 717, 342726, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 717, 0, 478  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : defor2_.jpg 
# names      : defor2__1, defor2__2, defor2__3 

plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

# first of all we can see thata the amount of the dispersed soil in the water is smaller, in fact the water is blue (not whita as in the 1992)
# this means that the NIR radiation as absorbed and not reflected

# let's plot the 2 images together

par(mfrow=c(2, 1))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

# to have the proof that the images are of the same location it is better not to look only at the river but find some roads or patches that remained the same over the years

############################################
# let's calculate the energy of the forest #
############################################

# DVI index

# the higher the better
# it is measure of the health of vegetation

# DVI = NIR - red

# 1992
dvi1992 <- l1992$defor1__1 - l1992$defor1__2 
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black"))(100)
plot(dvi1992, col=cl, main="DVI in the 1992")

#2006
dvi2006 <- l2006$defor2__1 - l2006$defor2__2 
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black"))(100)
plot(dvi2006, col=cl, main="DVI in the 2006")

# let's plot the two images together with par function
par(mfrow=c(2, 1))
plot(dvi1992, col=cl, main="DVI in the 1992")
plot(dvi2006, col=cl, main="DVI in the 2006")

# differencing two images of energy

divdiff <- dvi1992 - dvi2006
cld <- colorRampPalette(c("blue", "white", "red"))(100)
plot(divdiff, col=cld, main='Differences in DVI index')

# in this plot all the red area is places where we found energy lost

# now we make a final plot with all the three images

par(mfrow=c(3, 2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl, main="DVI in the 1992")
plot(dvi2006, col=cl, main="DVI in the 2006")
plot(divdiff, col=cld, main='Differences in DVI index')

# if you want to create a pdf you should use the pdf funciton
pdf('energy.pdf')
par(mfrow=c(3, 2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl, main="DVI in the 1992")
plot(dvi2006, col=cl, main="DVI in the 2006")
plot(divdiff, col=cld, main='Differences in DVI index')
dev.off()

pdf('dvi.pdf')
par(mfrow=c(1, 3))
plot(dvi1992, col=cl, main="DVI in the 1992")
plot(dvi2006, col=cl, main="DVI in the 2006")
plot(divdiff, col=cld, main='Differences in DVI index')
dev.off()


