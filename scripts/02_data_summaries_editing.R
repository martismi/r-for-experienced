#==============================================================================#
#                         #### Round two: Data ####
#==============================================================================#

# Setting your working directory is even more important in R
# than in Stata. As we are always working in code rather than 
# clicking our way around, we need to be in control of where
# R looks for files. We can find our current directory using

getwd()

# or by looking over your console.

# This is probably somewhere useless.
# setwd() will tell R where to begin looking for files.
# This is also where it will dump output files unless
# paths are specified.

setwd("C:/Users/martism/Dropbox/NTNU/Undervisning/R/ISS-R")

# once set you can see the wd over your console, and you can
# extract it using getwd()

getwd()

## At this point you should have a clean workspace, but it
# is usually a good idea to start every script with a cleaning 
# command. rm() removes specified objects from your workspace.

rm(list=ls())



avengers <- read.csv("data/avengers.csv", stringsAsFactors = FALSE)

# For larger files you may want to use the faster readr package and read_csv()
install.packages("readr") # you only need to install.packages() once.

## The package will then be stored locally or in your user folder in the cloud
library(readr) # You need to load the package every time you restart R.
## If you change computers you may have to reinstall the package.

avengers2 <- read_csv("data/avengers.csv")

# Excel files are not supported in base R. One option is readxl, another is xlsx
install.packages("readxl")
library(readxl)

avengers3 <- read_excel("data/avengers.xlsx")
# Note that the excel returns an extra column of rownames


# If your data is in Stata, SPSS or SAS format you can use the Haven package
install.packages("haven")
library(haven)

# .dta up to Stata v14 supported by haven (if 15 is different someone will fix)
avengers4 <- read_dta("data/avengers.dta")
# SPSS .sav
avengers5 <- read_sav("data/avengers.sav")
# SAS 
avengers6 <- read_sas("data/avengers.sas")

# We can also write to all these formats

write.csv(avengers, "data/written.csv")
#write.xlsx(avengers,"data/written.xlsx") # needs the xlsx package, which needs java
write_dta(avengers, "data/written.dta")
write_sav(avengers, "data/written.sav")
write_sas(avengers, "data/written.sas")

# R also has it's own, magical and superior, data format:

save(file = "data/written.Rdata", list = "avengers")

#==============================================================================#
# Fresh start - Let's clean:
rm(list=ls())

votes <- read_csv("data/personstemmer.csv")

str(votes)

#### Viewing our data
# We can look at our data in a grid cell format by using View() 
View(votes) # (the capital V in View is important)

# This opens the data in a new tab. We can view the data,
# but we cannot edit it. Because you shouldn't. 
# We will get to editing later.

# by using head() we can see the top of our dataset right in
# the console.
head(votes)

# An option for the number to report is available:
head(votes, 10)

# tail() will do the same but for the bottom end
tail(votes)
tail(votes,25)

# To view only the names of variables you can use names()
names(votes)


#### Describing our data

# We extract descriptives using summary()
summary(votes)
# We can also get summaries for single variables by adressing
# them directly using $
summary(votes$rangering)

# We can see the format of the data by using class()
class(votes$rangering)
class(votes$parti)


hist(votes$rangering)
table(votes$kjønn)
table(votes$valgt, votes$parti)

# Examining a variable in detail

# Mean, min, max - 
summary(votes$medietreff)
#quartiles
quantile(votes$medietreff)
# deciles
quantile(votes$medietreff, seq(0,1,.1))

# Mean and median far off. Skewed?

# standard deviation
sd(votes$medietreff)
# is also very large.

# we could just look
hist(votes$medietreff)

# but kurtosis and skewness can also be checked numerically
# install.packages("moments")
library("moments")

# skewness first:
skewness(votes$medietreff)

# and kurtosis:
kurtosis(votes$medietreff)

plot(density(votes$medietreff))
  
#==============================================================================#
#==============================================================================#

# Time to make some changes to our dataset

# We will transform our media hits variable into a dummy
# Method one:

# create an empty variable
votes$media <- NA

# make everything under the median 0s
votes$media[which(votes$medietreff < median(votes$medietreff))] <- 0

# make everything over the median 1s
votes$media[which(votes$medietreff >= median(votes$medietreff))] <- 1

# Check results. Always check results.

plot(votes$media, votes$medietreff)
ftable(votes$media)


# Method two - ifelse
# if condition is true, then do this, if not, do that
# If medietreff is under median, make it 0. If not, make it 1
votes$media <- ifelse(votes$medietreff < median(votes$medietreff), 0, 1)

# check again
plot(votes$medietreff, votes$media) 


# A different transformation using ifelse. Let's make varas missing:
votes$valgt2 <- ifelse(votes$valgt == "Vara", NA, votes$valgt)

table(votes$valgt, votes$valgt2, useNA = "always")

#==============================================================================#
# log transformations are also simple

votes$ln_medietreff <- log(votes$medietreff)

# The difference between preliminary and final rank?
votes$rankdiff <- votes$rangering - votes$rangering_original

# Votes per media hit?
votes$vpm <- votes$personstemmer / votes$medietreff

# Centering variables
votes$c_pstem <- votes$personstemmer - mean(votes$medietreff)

# estimate Pearson's R
cor(votes$personstemmer, votes$medietreff) 

# with confidence intervals
cor.test(votes$personstemmer, votes$medietreff)

# advanced 
religion$nmiss <- apply(religion[, c("aksept_homofili", "aksept_abort",
                                     "aksept_aktiv_dodshjelp")],
                        1, function(x)
                          length(which(is.na(x))))


#==============================================================================#
# R can save your whole workspace to the .Rdata format

save.image("data/workspacetest.Rdata")

# These can then be loaded back in using load()
# Let's clean out first:

rm(list = ls())

# And reload:
load("data/workspacetest.Rdata")

#==============================================================================#
#==============================================================================#

