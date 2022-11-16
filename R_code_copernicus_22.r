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

### !!! FINO QUI !!! ###

# you can crop your image on a certain area

# longitude from 0 to 20
# latitude from 30 to 50

# crop the stack to the extent of Sicily
ext <- c(0, 20, 30, 50)
# stack_cropped <- crop(snowstack, ext) # this will crop the whole stack, and then single variables (layers) can be extracted

ssummer_cropped <- crop(sce_summer, ext)
swinter_cropped <- crop(sce_winter, ext)

p1 <- ggplot() + 
geom_raster(sce_summer_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during my birthday!")

p2 <- ggplot() + 
geom_raster(sce_winter_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during freezing winter!")

p1 / p2
