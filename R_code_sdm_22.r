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










