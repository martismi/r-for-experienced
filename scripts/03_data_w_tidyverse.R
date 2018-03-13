#==============================================================================#
# #3 - Data management with the tidyverse
# In this script you will learn a few functions that will help you tidy, subset, 
# and merge your data.
#==============================================================================#
#
#           Style tip: Load all packages at the start of the script.
#      This makes it easier to quickly see what packages are used, and to
#           install every package necessary to run the whole thing.
#
#============================== Package load ==================================#

# We already looked at these packages for reading data:
library(readxl)
library(readr)
library(haven)

# For data management we will also need some extra packages. The tidyverse
# includes several useful packages, 

# install.packages("tidyverse")

library(tidyr)
# tidyr is for tidying your data - cleaning data and making sure it's readable
# to other functions

library(dplyr)
# dplyr is for data manipulation

library(countrycode)
# countrycode contains a library of different country codes that help us merge
# data from different sources.

# Both are sort of data manipulation, but the dplyr functions all follow the
# same logic, while tidyr contains those that don't fit the pattern.

# Functions that will be featured:
##  tidyr : gather(), separate()
##  dplyr : select(), filter(), join()

#==============================================================================#
#
# Style tip: Structure your script with commented lines of = or other symbols.
#             (= or - are the most aesthetically pleasing)
#
#================================= Data load ==================================#
####                        Cleaning data with Tidyr                        ####

# Clean
rm(list=ls())

# Remember to set your working directory
setwd("C:/Users/martism/Dropbox/NTNU/Undervisning/R/ISS-R")

# Let's read some population data from the World Bank.
# This Excel file comes straight from the web:
pop <- read_excel("data/API_SP.POP.TOTL_DS2_en_excel_v2.xls")
head(pop)
# use list.files() to copy paste long filenames, or copy from explorer

# So that doesn't look right.

View(pop)

# The World Bank stores data in a horrible format. 
# There is a nice R package to help us around this, but this is an opportunity
# to learn! Let's try to turn this horrible format into something useful. 

# We can see that variable names start on line 3, so let's read that dataset
# again, but with the skip argument in read_excel():
pop <- read_excel("data/API_SP.POP.TOTL_DS2_en_excel_v2.xls", skip = 3)
head(pop)

# Still broken, but now our variable names are in the right place.
# To move things around we will use the gather() function from tidyr:

?gather # Check arguments. Our key is years, our values are pop counts
names(pop) # check names to see how many years we have

pop <- gather(pop, "year", "pop", '1960':'2017')

# Now all of the year variables are turned into values on a new year variable.
# How's our data? Check with summary:
summary(pop)

# That was simple. Let's try another WB variable, assuming the data is 
# formatted in the same way:
gdp <- read_excel("data/API_NY.GDP.MKTP.CD_DS2_en_excel_v2.xls", skip = 3)
head(gdp)
# Looks good.
gdp <- gather(gdp, "year", "gdp", '1960':'2017')
summary(gdp)
# So more missing, but not more than expected if you look at the original data. 

# Let's add a last variable from a set I prepared earlier:
agri <- read_excel("data/API_AG.LND.ARBL.ZS_DS2_en_excel_v2.xls")
head(agri)

# Oh dear, it seems I've been an idiot and somehow spliced the year and value
# variables together into a single variable! How silly of me.
# Let's fix it using separate():

?separate # check arguments

agri <- separate(agri, yearagriland,
                 into = c("year","agriland"),
                 sep = 4, convert = T) #, 
#remove = F) #  # you may want to test the command with
# the remove option set to false. 
# This way you don't break your data.
head(agri)
summary(agri)

# without "convert = T" you would need to
# agri$year <- as.numeric(agri$year)
# agri$agriland <- as.numeric(agri$agriland)


# To test separate with a different type of argument, let's say we need each
# part of the indicator code as a separate variable. 

# If you don't specify a separator, tidyr might fix things for you:
agri <- separate(agri, 'Indicator Code',
                 into = c("first", "second", "third", "fourth"))
head(agri)

# This is annoying, because it won't let me show you how to put text in the 
# 'sep' argument. Let's say we want to split the variable name into what's 
# in the parentheses and what's outside them.

# First we try the same method as before, i.e. letting tidyr try:  
separate(agri, 'Indicator Name',
         into = c("first", "second"))#, "third", "fourth", "fifth","sixth"))
# Nope, no good. Tidyr tries to split at every space and symbol. It wants one 
# variable for each word, and one for the nothingness after the last parenthesis

# We can tell separate to split on punctuation:
agri <- separate(agri, 'Indicator Name',
                 into = c("first", "second", "third"),
                 sep = "[:punct:]")

# This gives us three new variables (we can throw away the empty one in the 
# middle later) with the data we wanted. We did lose the percentage sign.
# Sometimes you won't find perfect solutions, but we can fix things. We can put
# the % back using paste()
agri$third <- paste("%", agri$third)
head(agri$third)

# To be honest with you, I may have used paste() to make the spliced 
# yearagriland variable in the first place...

agri$yearagriland <- paste(agri$year, agri$agriland, sep="")
head(agri$yearagriland)

# paste() is great for things like making new ID variables
agri$countryYear <- paste(agri$`Country Code`, agri$year, sep = "")
head(agri$countryYear)

#==============================================================================#
#
# Style tip: Never exceed a line length of 80 characters. These dividers are 80.
#
#==============================================================================#


#==============================================================================#
####                   Subsetting variables using dplyr                     ####
#==============================================================================#


# Now that we have some data, we can put it together into a set.
# Let's see what's in the sets
names(pop)
names(gdp)
names(agri)

# So there's a lot of extra stuff here we don't need or want. Before we try to 
# merge our datasets we should get rid off that. dplyr can help!

# dplyr is nice package of lots of functions for subsetting and summarising data
# it uses pipes %>% to do lots of things at once, but can also be used without

# To remove variables, we can select() the ones we want:
pop <- select(pop, 'Country Name', 'Country Code', year,pop)
gdp <- select(gdp, 'Country Code', year,gdp)
agri <- select(agri, "agriland")
# oops...
names(agri)
# Seems we have more than one variable with the same name.
# dplyr doesn't like this. 

# Rename variables: We only need three of them
names(agri) <- c("asd", "das", "Country Code", letters[1:7],
                 "year", "agriland", "blah","blarg")
tail(agri)
# Looks good. select() again
agri <- select(agri, 'Country Code', year, agriland)
summary(agri)
# All is well.

#==============================================================================#
#                         #### Merging data ####
#==============================================================================#

# dplyr comes with a range of merge functions. 
?join

# left join() will merge two sets, keeping all rows in the first set supplied,
# while adding data on the variables from the second set.
wbdata <- left_join(pop, gdp)
# If you don't specify any more than the datasets to be merged, dplyr will
# find variables on its own. Notice the warning.
head(wbdata)
# Our vars are now in one set. Because both our sets have rows for the same
# units, the resulting set has just as many rows.

# right join() will merge two sets, keeping all rows in the second set supplied
# while adding data on the variables from the first set. # You can also specify
# the variables to be merged on using 'by':
# To join by different variables on x and y use a named vector. 
# For example, by = c("a" = "b") will match x.a to y.b.

wbdata <- right_join(wbdata, agri, by= c("Country Code", "year"))
# Ah, another error. It seems our first two sets have stored years as
# characters rather than numbers. Before we can merge we need to fix this.


wbdata$year <- as.numeric(wbdata$year)
wbdata <- right_join(wbdata, agri, by= c("Country Code", "year"))
head(wbdata)
# Success! Notice that integer and numeric work together.

plot(wbdata$pop, wbdata$gdp)
plot(wbdata$agriland, wbdata$gdp)

# full_join() keeps all rows from both sets

# Let's say we want to join in some other data, like polity.

# First we read the data:
polity <- read_excel("data/REG_P2_ORIG.xls")
head(polity)
# There's no character country code. We could try merging on country names, but
# that tends to get messy (Cote d'Ivoire vs Ivory Coast, Romania vs Rumania)
# Luckily there's a premade ID matrix for you that contains a range of different
# ID variables!

# install.packages("countrycode") #
library(countrycode)
data("countrycode_data")
View(countrycode_data)

# Be sure that you know which variable in you different datasets correspond to
# each other. While our data comes from the World Bank, they use the ISO3 
# identifier, not the WB.

# You can check which countries are not the same:
countrycode_data$iso3c[which(countrycode_data$iso3c != countrycode_data$wb)]



# First add the key to one set. Use left join to keep all your data without
# adding extra empty units.
fullData <- left_join(wbdata, countrycode_data, by = c("Country Code" = "iso3c"))
head(fullData)

# That's a lot of variables. It's best to clean data before merging:
countrycode_data <- select(countrycode_data, cown, iso3c)
fullData <- left_join(wbdata, countrycode_data, by = c("Country Code" = "iso3c"))
head(fullData)
# Much better.

# Now we can add the polity data using COW numbers

fullData <- left_join(fullData, polity, by = c("cown" = "ccode", "year"))
summary(fullData)


### What happens if you don't include "year"? Why? ###

# other join functions are
# inner_join(), which keeps units with data in both sets
# semi_join(), #return all rows from x where there are matching values in y,
# keeping just columns from x.
# anti_join(), "return all rows from x where there are not matching values
# in y, keeping just columns from x."

#==============================================================================#
# R-package tip: You can also use the 'wbstats' package to get world bank data:
install.packages("wbstats")
library(wbstats)
head(
  wb(indicator = c("SP.POP.TOTL"), mrv = 60)
)
#==============================================================================#

# select() subsets variables
# filter() subsets units

# I'll clean the workspace first:
rm(list=setdiff(ls(),"wbdata"))

# filter() needs you to specify which set you want to subset from, and then what
# variables and what criteria. Let's get all country years with more than 
# 2,000,000 inhabitants: 
newdat <- filter(wbdata, pop > 2000000)

# There are a few operators you can use:
# The year 1996 (==)
newdat <- filter(wbdata, year >= 1996)

# All years from 1996 to max, including 1996 (>=)
newdat <- filter(wbdata, year >= 1996)

# All years from 1996 to min, including 1996 (<=)
newdat <- filter(wbdata, year <= 1996)

# All years except 1996 (!=)
newdat <- filter(wbdata, year <= 1996)

# Subset all units with missing agriland (is.na)
newdat <- filter(wbdata, is.na(agriland))

# Remove all units with missing agriland (!is.na)
newdat <- filter(wbdata, !is.na(agriland))


#==============================================================================#

# We can combine more criteria with & (and) and/or | (or)

# Here we subset those country years that have 2mil pop and a gdp over 10bil:
newdat <- filter(wbdata, pop > 2000000 & gdp < 10000000000)

# We can subset on text or factors as well. Here's Brazil:
newdat <- filter(wbdata, `Country Code` == "BRA")

# Here's Brazil and Norway:
newdat <- filter(wbdata, `Country Code` == "BRA" | `Country Code` == "NOR")

# More values on the same variables can also be done this way (more elegant):
newdat <- filter(wbdata, `Country Code` %in% c("BRA", "NOR","SWE"))

# You can also combine multiple criteria
newdat <- filter(wbdata, `Country Code` %in% c("BRA", "NOR", "SWE") & 
                          year %in% c(1994, 1998, 2000))


# Dropping all country years on given criteria may not always be what you 
# want to do. For example, you may want to keep all observations for countries
# that at one point fulfilled some criteria. Let's say you want all countries
# that at some point used more than 20% of its land area as agricultural land.

# First you make a list of country IDs for the countries:
countrylist <- unique(wbdata$`Country Code`[which(wbdata$agriland>=20)])
# To select those in list:
filter(wbdata, `Country Code` %in% countrylist)
# To drop those in list:
filter(wbdata, !`Country Code` %in% countrylist)


                              #### END ####
#==============================================================================#
#==============================================================================#
#==============================================================================#
