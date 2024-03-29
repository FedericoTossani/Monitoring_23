# this is the first code in github wrote during monitoring ecosystem changes and functioning course
# because I am currently working I will be following the 2021/2022 lessons recorded on Panopto

# here are the first input data, from Costanza who collected streams' water and from Marta who studied fishs genome
water <- c(100, 200, 300, 400, 500)
fishes <- c(10, 50, 60, 100, 200)

#plot is the base function of R with which one can plot variables
plot(water, fishes)

# now that we have created 2 array it is possible to store them in a table
# A table in R (and also in general) could be called data frame

streams <- data.frame(water, fishes)
streams


# the following piece of code is important to set the working directory, that basically is the folder where we will save data
# Base on the different environment in which one is working it could have different locations.

# For Linux (Ubuntu, Fedora, Debian, Mandriva) users
# setwd("~/lab/")

# setwd for Windows
setwd("C:/lab/")

# setwd Mac
# setwd("/Users/yourname/lab/")

# write.table is the the function that can save the data frame we have just created in the working directory
write.table(streams, file="my_first_table.txt")

# on the other hand the function read.table is the one we need to import data into R
# remeber the quotes "" every time we need to import or install somethings that come from outside R!!
read.table("my_first_table.txt")

# now we assign a name to the table
fede_df <- read.table("my_first_table.txt")

# this is the way to store data into R from now on with fede_df I can see the data inside my_first_table.txt

# the most basic way to calculate statistics from a data frame is the summary function
summary(fede_df)

# if I am interested only in one variable of the data frame I should use $ plus the name of the variable
# to get the information only on that particular variable
summary(fede_df$fishes)

# hist() is the function you need to create beatiful histogram
hist(fede_df$fishes)
hist(fede_df$water)

# ---------------------------- second code

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

# is the function to shut down the plotting device (the graph in our case)
# dev.off()

# Excercise: plot the first four bands with two rows and two columns

#before plotting I set the color palette foor the red and NIR band
clr <- colorRampPalette(c("dark red", "red", "pink"))(100)
cln <- colorRampPalette(c("red", "orange", "yellow"))(100)


par(mfrow=c(2,2))
plot(l2011$B1_sre, col = clb)
plot(l2011$B2_sre, col = clg)
plot(l2011$B3_sre, col = clr)
plot(l2011$B4_sre, col = cln)

# stretch basically stretch the color in orden to let us see the color better
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin") # Natural color

# now we are going to put the NIR band in one of these positions in order to see the health of a tree.
# the higher the reflectance in the NIR the higher the health of the tree
# we have only the red, the green and the blue channel of the RGB. normally we move all the band to right so we remove the blue band and add the NIR in the red channel.

plotRGB(l2011, r=4, g=3, b=2, stretch="Lin") # False color, NIR in the red channel
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin") # False color, NIR in the green channel

# with NIR band we can see also the humidity inside the forest. For examples in the images we are using it is visibile a lung-type patter inside the forest
# that is where the water is flowing. In violet is the bare soil or agricultural fields. 
# To better see where the forest has been cut it is usefull to put the NIR in the blue channel.
# In this way all the bare soil become yellow!!

plotRGB(l2011, r=3, g=2, b=4, stretch="Lin") # False color, NIR in the blue channel


par(mfrow=c(2,2))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin") # Natural color
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin") # False color, NIR in the red channel
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin") # False color, NIR in the green channel
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin") # False color, NIR in the blue channel


# In general in monitoring ecosystem there are 2 steps:
# 1. Explorative analysis: take the nowdays data to have an idea of the current status.
# 2. Multitemporal analysis: in which we are going to see how the situation changed from to past to today.

# our next step is to see the differences between 2011 and 1988

# first we try to use another kind of stretch, the histogram stratching. this will enance a lot the differences from one place to another

plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# now let's star working on 1988 data. How to import the data is explained at the beginning of the file.

l1988
#class      : RasterBrick 
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
#source     : p224r63_1988.grd 
#names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
#min values : 0.000000e+00, 7.159799e-03, 1.300000e-03, 6.015250e-04, 0.000000e+00, 2.916000e+02, 0.000000e+00 
#max values :    1.0000000,    0.4799183,    0.4921374,    0.6595379,    0.6034456,  305.2000000,    0.5607360 

# with par function we are plotting the two images in the same multiframe plot

par(mfrow=c(2, 1))
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# same images but with NIR in the blue channel, this will enance the agricultural field
par(mfrow=c(2, 1))
plotRGB(l1988, r=3, g=2, b=4, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

# -------------------------- third code

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

# --------------------- fourth code

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

#-------------------------------- fifth code

# Quantitative estimates of forest loss

# we will write a code to estimate the amount of squared meters lost in a tropical forest

# Packages we need

library(raster)
library(RStoolbox) # classification
# install.packages("ggplot2")
library(ggplot2)
# install.packages("gridExtra")
library(gridExtra) # for grid.arrange plotting

# Set the working directory we are working on
setwd("C:/lab/")

# to import our data we can code in two different way:
# FIRST
deforlist <- list.files(pattern = "defor")
deforlist

# after creating the list let's apply the brick function to import all the set of layers with brick()
list_defor <- lapply(deforlist, brick)

# and at the end try to plot it to see what we have

plot(list_defor[[1]]) # [[1]] is the number of the file I want to plot from the list. Remember the doulbe parentesis!!

# now I will create the 2 separate images

l1992 <- list_defor[[1]]
l2006 <- list_defor[[2]]

# The band we have in our images are:
# NIR 1, RED 2, GREEN 3

# SECOND
# I can import the two images individually, but it is not so nice

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# then there are also two possible way to plot it, but with the ggRGB is more beautiful
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
ggRGB(l2006, r=1, g=2, b=3, stretch="lin")

# normal multiframe plot
par(mfrow=c(1,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# multiframe with ggplot2 and gridExtra
p1 <- ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(l2006, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)

# unsupervised classification
# this is a powerful process in which the software analize the images and classify the pixels based on their reflectance
# in this way we can check how many pixels are from forest or from bare soil or agricultural land
# another type of classification is the supervised in which you are the one who decidede which pixel are from forest and which one are from bare soil or urbanized area
# and then the software make the analysis

l1992c <- unsuperClass(l1992, nClasses=2)
l1992c

plot(l1992c$map)
# class 1: agriculture
# class 2: forest

# freq() is the function we need to calculate frequencies. In our case the number of pixels of forest and bare soil
freq(l1992c$map)
#      value   count
# [1,]     1   35319
# [2,]     2  305973

total1992 <- 35319 + 305973

prop1992 <- freq(l1992c$map) / total1992
propforest92 <- 0.8965138
propagri92 <- 0.1034862

# set.seed() would allow you to attain the same results ...

# build a 1992 dataframe
cover <- c("Forest","Agriculture")
prop_1992 <- c(propforest92, propagri92)
percent_1992 <- c(propforest92*100, propagri92*100)

# now let's do the same process but for 2006
l2006c <- unsuperClass(l2006, nClasses=2)
plot(l2006c$map)
# class 1: forest
# class 2: agriculture

# this is with 3 different classes
#l2006c3 <- unsuperClass(l2006, nClasses=3)
#plot(l2006c3$map)

total2006 <- 342726
prop2006 <- freq(l2006c$map) / total2006
prop2006
propforest06 <- 0.5211627
propagri06 <- 0.4788373

# build a 2006 dataframe
cover <- c("Forest","Agriculture")
prop_2006 <- c(propforest06, propagri06) # instead of doing this vector with the number is better to use an object that contain the numbers
percent_2006 <- c(propforest06*100, propagri06*100)

# let's calculate percentages and proportions for both images
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

proportions <- data.frame (cover, prop_1992, prop_2006)
proportions

# let's plot them!
ggplot(proportions, aes(x=cover, y=percent_1992, color=cover)) +
  geom_bar(stat="identity", fill="white")

ggplot(proportions, aes(x=cover, y=percent_2006, color=cover)) +
  geom_bar(stat="identity", fill="white")

p1 <- ggplot(proportions, aes(x=cover, y=prop_1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)
p2 <- ggplot(proportions, aes(x=cover, y=prop_2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)

grid.arrange(p1, p2, nrow=1)

# --------------------------- sixth code

###################################
# Visualizing Coprnicus data in R #
###################################

# Packages we need

# install.packages("ncdf4")
# install.packages("viridis")

library(ncdf4)
library(raster)
library(RStoolbox)
library(viridis)
library(ggplot2)
library(patchwork)

# Set the working directory

# setwd("~/lab/copernicus/") # Linux 
setwd("C:/lab/copernicus/")  # windows
# setwd("/Users/name/lab/copernicus/") # mac

# Import the data!
# this kind of image is composed only by one layer so the raster() function is perfect to import it
snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")

# If you want to see how many layers are inside Copernicus data let's import it with brick()
##### ATTENTION #####
# USING THE BRICK() FUNCTION TO IMPORT FILES CHANGE THE NAME OF THE LAYER
# snow20211214_ <- brick("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")

snow20211214
# class      : RasterLayer 
# dimensions : 5900, 36000, 212400000  (nrow, ncol, ncell)
# resolution : 0.01, 0.01  (x, y)
# extent     : -180, 180, 25, 84  (xmin, xmax, ymin, ymax)
# crs        : +proj=longlat +datum=WGS84 +no_defs 
# source     : c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc 
# names      : Snow.Cover.Extent 
# z-value    : 2021-12-14 
# zvar       : sce 

snow20211214_ 
# class      : RasterBrick 
# dimensions : 5900, 36000, 212400000, 1  (nrow, ncol, ncell, nlayers)
# resolution : 0.01, 0.01  (x, y)
# extent     : -180, 180, 25, 84  (xmin, xmax, ymin, ymax)
# crs        : +proj=longlat +datum=WGS84 +no_defs 
# source     : c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc 
# names      : X2021.12.14  <- !!!!! HERE IS THE DIFFERENCE !!!!!
# Date/time  : 2021-12-14 
# varname    : sce 


plot(snow20211214)

cl <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(snow20211214, col=cl)

# this palette is awful, it is not color-blind friendly!!!
cl <- colorRampPalette(c("blue","green","red"))(100)
plot(snow20211214, col=cl)

# Let's play with ggplot function and different viridis palette!
# Viridis is a color blind friendly palette, and also it is already done (so you don't need to create one, let's be lazy!!) and easy to use!

# ggplot function
ggplot() + 
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent))  

# ggplot function with viridis
ggplot() + 
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis() 

ggplot() + 
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis(option="cividis") 

ggplot() + 
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis(option="cividis") + 
ggtitle("cividis palette")

# -------------------------- #
# Second day on copernicus!! #
# -------------------------- #

# now we have two images!
# so it is better to import it together with a single function!
cop_list <- list.files(pattern="SCE")
cop_list

cop_list_rast <- lapply(cop_list, raster)
cop_list_rast

# making a stack is useful to have the data that come from different images in one object
# this is particularly useful when we have hundreds of images
snowstack <- stack(cop_list_rast)
snowstack

# let's assign the 2 images to two variable so we can analize it separetly
sce_summer <- snowstack$Snow.Cover.Extent.1
sce_winter <- snowstack$Snow.Cover.Extent.2

# now we are going to plot the 2 images with ggplot

# Summer image
ggplot() + 
geom_raster(sce_summer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during Duccio's birthday!")

# Winter image
ggplot() + 
geom_raster(sce_winter, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during freezing winter!")

# let's patchwork them together
# first of all we need to assign a name to each plot
p1 <- ggplot() + 
geom_raster(sce_summer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during my birthday!")

p2 <- ggplot() + 
geom_raster(sce_winter, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during freezing winter!")

# use patchwork library
# with the + we have one image beside the other
# with the / we have one image on top of the other
p1 / p2

# How to crop an image based on coordinates!!

# Frist of all set the coordinates
# long: from0 to 20
# lat: from 30 to 50

# crop the stack to the extent of Italy
# first two numbers are the longitude and the last two are the latitude
ext <- c(0, 20, 30, 50)

# this will crop the whole stack, and then single variables (layers) can be extracted
stack_cropped <- crop(snowstack, ext) 

sce_summer_cropped <- crop(sce_summer, ext)
sce_winter_cropped <- crop(sce_winter, ext)

p1 <- ggplot() + 
geom_raster(sce_summer_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during Duccio's birthday!")

p2 <- ggplot() + 
geom_raster(sce_winter_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during freezing winter!")

p1 / p2

# ----------------------- seventh code

# Let's play with Greenland Data!!

# We will investigate ice melt
# Proxy: LST

# Packages we need
library(raster)
library(RStoolbox) # classification
library(ggplot2)
library(gridExtra) # for grid.arrange plotting
library(patchwork)
library(viridis)

# Set the working directory we are working on
setwd("C:/lab/greenland/")

# First let's create a list with the file we need
lst_list <- list.files(pattern = "lst")
lst_import <- lapply(lst_list, raster)
lst_gr <- stack(lst_import)

# colorRampPalette() is the function to create a palette to assign to the varius plot we will do
cl <- colorRampPalette(c("blue", "light blue", "pink", "yellow"))

plot(lst_gr, col=cl)

# GGPLOT!!

# let's plot the first image about greenland in 2000
ggplot()+
geom_raster(lst_gr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000))+
ggtitle("lst in 2000")
scale_fill_viridis(option="magma")

# let's plot the first image about greenland in 2015
ggplot()+
geom_raster(lst_gr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015))+
ggtitle("lst in 2015")
scale_fill_viridis(option="magma")

# to plot them together we need to assign a name to each plot

p1 <-  ggplot()+
        geom_raster(lst_gr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000))+
        ggtitle("lst in 2000")
        scale_fill_viridis(option="viridis")

p2 <- ggplot()+
        geom_raster(lst_gr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015))+
        ggtitle("lst in 2015")
        scale_fill_viridis(option="viridis")

p1 + p2

# let's see the frequency distribution of value in lst_2000 and lst_2015

par(mfrow=c(1, 2))
hist(lst_gr$lst_2000)
hist(lst_gr$lst_2015)

par(mfrow=c(2, 2))
hist(lst_gr$lst_2000)
hist(lst_gr$lst_2005)
hist(lst_gr$lst_2010)
hist(lst_gr$lst_2015)

plot(lst_gr$lst_2010, lst_gr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
abline(0, 1, col="red")

# excercise let's plot everythings together!!
par(mfrow=c(4, 4))
hist(lst_gr$lst_2000)
hist(lst_gr$lst_2005)
hist(lst_gr$lst_2010)
hist(lst_gr$lst_2015)
plot(lst_gr$lst_2000, lst_gr$lst_2005, xlim=c(12500, 15000), ylim=c(12500, 15000))
abline(0, 1, col="red")
plot(lst_gr$lst_2000, lst_gr$lst_2010, xlim=c(12500, 15000), ylim=c(12500, 15000))
abline(0, 1, col="red")
plot(lst_gr$lst_2000, lst_gr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
abline(0, 1, col="red")
plot(lst_gr$lst_2005, lst_gr$lst_2010, xlim=c(12500, 15000), ylim=c(12500, 15000))
abline(0, 1, col="red")
plot(lst_gr$lst_2005, lst_gr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
abline(0, 1, col="red")
plot(lst_gr$lst_2010, lst_gr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
abline(0, 1, col="red")

# now let's discover the lazy method!!
# we need to use the stack! anche the pairs() function

pairs(lst_gr)

# what are we plotting??
# First there are for sure the 4 histogram showing the distributions of frequencies in every images
# Then we have also the lst variable of the different years compared.#
# Let's see the graph showing the lst in 2000 compared with the one of 2015:
# we see that in the scatter plot there is a small peak in the bottom left corner.
# this peak is telling us that the lowest temperatures in 2015 (Y axies) are higher then that in 2000
# So this is particularly important because it is the lowest tempèeratures the keeps the snow cover and ice
# from one year to the other

# ---------------------- eighth code

# R code for species distribution modelling

# Packages we need

library(raster)
library(rgdal)
library(sdm)

# Set the working directory we are working on
setwd("C:/lab/")

# system.file() is the function to use to inspect the file contained in a package!
file <- system.file("external/species.shp", package = "sdm")

# shapefile() function does the job as raster() do but for .shp files
species <- shapefile(file)

# how many occurrances are there?
species[species$Occurrence == 1,] # this is a query!! we want to now how many 1 there are in the species data set. the comma ( , ) is the symbol to use when a query is finished
species[species$Occurrence == 0,]

presences <- species[species$Occurrence == 1,]
absences <- species[species$Occurrence == 0,]

# let's plot some data!!
plot(species, pch=19, col="dark green")

# with plot we can't show both precences and absences because the second plot will remove the first one
# to do so we need to use points() function
plot(presences, pch=19, col="red")
points(absences, pch=19, col="black")
plot(preds$vegetation, col=cl)
points(presences, pch=19, col='blue')

# Now we will try to calculate the probability to find a certain species in an area where we don't have presence data.
# to do so we need to have several raster layer containig the environmental variable (the so called predictors).

path <- system.file("external", package = "sdm")

list <- list.files(path, pattern='asc', full.name=T)

# it this case is useless the lappl() with raster() fucntions because the ASCII files are already read by R
preds <- stack(list)

# let's plot the predictors

cl <- colorRampPalette (c('black', 'purple', 'green', 'orange', 'yellow'))(200)
plot(preds, col=cl)

# plot elevation and the species occurrences
plot(preds$elevation, col=cl)
points(presences, pch=19, col='blue')

# let's do the same with temperature
plot(preds$temperature, col=cl)
points(presences, pch=19, col='blue')

# with vegetation
plot(preds$vegetation, col=cl)
points(presences, pch=19, col='blue')

# with precipitation
plot(preds$precipitation, col=cl)
points(presences, pch=19, col='blue')

# ----- # Day 2 # ----- #

# let's use the code of the past lesson from a source file!
source('R_code_source_sdm.r')

# Let's use a model to calculate the probability!
# First we have to explain to the software which are the data we are going to use
datasdm <- sdmData(train = species, predictors = preds)

# Model!!
# the matemathical = in R is the tilde ~ (write it with Alt+126)
# occurrence and temperature are the 2 variable of the model Y = Occurrence and X = temperature
# than the model will calculate the slope and the intercept
# in our case we have 4 variable so with the + we can put every variable in the model
# METHODS we have different methods but one of the most used is the linear, and when we have multiple predictors it is called "generalized linear model"
# generalized means that you are generalizing the all formula with all the variable and that they are normally distributed (there are some assumptions)
m1 <- sdm(Occurrence~temperature+elevation+precipitation+vegetation, data=datasdm, methods="glm")
m1

# OUTPUT!!

# class                                 : sdmModels 
# ======================================================== 
# number of species                     :  1 
# number of modelling methods           :  1 
# names of modelling methods            :  glm 
# ------------------------------------------
# model run success percentage (per species)  :
# ------------------------------------------
# method          Occurrence       
# ---------------------- 
# glm        :        100   %

# ###################################################################
# model performance (per species), using training test dataset:
# -------------------------------------------------------------------------------
#
# ## species   :  Occurrence 
# =========================
#
# methods    :     AUC     |     COR     |     TSS     |     Deviance 
# -------------------------------------------------------------------------
# glm        :     0.88    |     0.7     |     0.69    |     0.83     

# Predict the Occurrence based on the model!!
# we should explain the model we are using and the data
p1 <- predict(m1, newdata=preds)

# plot it!!
plot(p1, col=cl)
points(presences, pch=19)

# at the end we will stack everythings together so we can plot it and it is easier to compare
s1 <- stack(preds, p1)
plot(s1, col=cl)

# to change the name of all the variable (in order to have beatiful title in the graph) we will use the names() function
names(s1) <- c('Elevation', 'Precipitation', 'Temperature', 'Vegetation', 'Species Distribution Model')
plot(s1, col=cl)

# ----------------------------- ninth code

# R_code_multivar.r

# Packages we need
library(vegan)

# Set the working directory we are working on
setwd("C:/lab/")

load("biomes_multivar.RData")
ls()

# plot per species matrix
head(biomes)

multivar <- decorana(biomes)
multivar

plot(multivar)

# biomes names in the graph:
attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
ordispider(multivar, type, col=c("black","red","green","blue"), label = T) 

pdf("multivar.pdf")
plot(multivar)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
ordispider(multivar, type, col=c("black","red","green","blue"), label = T) 
dev.off()
