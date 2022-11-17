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










