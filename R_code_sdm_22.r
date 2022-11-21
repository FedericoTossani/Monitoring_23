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
































