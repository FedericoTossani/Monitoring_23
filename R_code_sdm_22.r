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

plot(species, pch=19, col="dark green")
