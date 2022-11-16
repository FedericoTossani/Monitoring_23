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
