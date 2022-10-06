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



