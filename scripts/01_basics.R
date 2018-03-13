#==============================================================================#
#==============================================================================#
#      #####                 1. Script and console                 #####       #
#==============================================================================#
#==============================================================================#

# First familiarize yourself with the RStudio environment

# A lot of parallels can be drawn to Stata:

## Editor = do-file
## The editor window is like a do-file editor. Here you can write
## code like you would in a do-file and run it using Ctrl+Enter.

## Console = command og results. 
## You can input code directly into the console. Results and error
## messages will also appear here. 

## Workspace /= Variables, but similar.
## While Stata shows you the variables in the currently loaded dataset,
## RStudio shows you all the datasets currently loaded (as well as other
## objects in memory).

## The data viewer is also available once we load data
## Each loaded dataset can be viewed using View(). They will then open
## in a new tab.

## Help = Help
## The R command for help is ?. Try putting '?table' in the console.

## Plots - Rather than opening in a new window, they will appear
## in the main window (but can be popped into a new window).

# New to RStudio:

# Packages = All your add-on packages of functions.
## R is modular. This means you have a base package of functions that
## comes pre-installed, but you can also add lots of extra functions.
## These come in packages that you can manage from this tab.

# Missing from RStudio:
# Properties
## Since we can have lots of datasets, this info will have to be
## extracted for each set. The summary() and class() commands 
## will usually be enough.

#==============================================================================#

## This is your script, editor, or source pane.
## Write code here.
## To run the code, press CTRL/CMD + ENTER
##  CTRL/CMD + ENTER: If you have highlighted som code, only this will run
##  CTRL/CMD + ENTER: If you have NOT highlighted som code, the line your
##    marker is on will run.

## Adding hash/pound (#) tells R that everything on a line after it
##  is to be disregarded. This way you can add comments to code.

## You can divide your script into chunks by using four #s
# Chapter name ####
## and navigate these using the dropdown below.


#           #####     R is a very advanced calculator:    #####

# Simple calculation:
1 + 1
12 * 53 / 9 ^2 # add parentheses to clarify


##  Validation:
  # by putting == after a calculation we ask R whether our answer 
  # is correct.
1 + 1 == 2
1 + 2 == 2

# This will seem more useful as you advance.

##  See how R will ignore anything after a #
10 * 10 # + 10 * 3


#==============================================================================#
#
#     ####                       2. Objects                      #####
#
#==============================================================================#

# R is object based.
# That means we store things in objects in memory.
# We can store pretty much anything (given enough RAM)

##  Objects can be created in two ways: Using = or using <-.
# Note the crucial difference between one and two ='s
# Either command needs you to supply a name for your object

a_number <- 10
another_number = 12

# objects are then accessed by their names
a_number
another_number

# WHILE YOU CAN USE = TO CREATE OBJECTS, DON'T
# Object creation should be done with <-, while 
# = should be kept in functions. Ordnung muss sein.

##  Objects can store anything
hello <- "Such as text"
hello

# or logical operators
yeahnay <- 1 == 2

# EVERYTHING* in R is case sensitive
Hello <- "Quick brown fox"
hello <- 10

Hello
hello

## Objects can contain more than one number or piece of text
# Objects come in different classes. One of these is the vector:
my_vector <- 1:10  # two numbers with a : between them creates a sequence
my_vector

# Try putting a larger number first to see what happens!

##  Objects can be named anything*:
lars_sponheim <- "Hver mann sin h�ne!"
lars_sponheim

# Objects can be used in place of what you put in them
# numeric values can be stored and then used in computations
ten <- 10

ten + my_vector
ten * my_vector
ten / my_vector
my_vector^2
my_vector^ten

log(my_vector)
exp(my_vector)

exp(log(my_vector))

# Text, obviously, cannot be used in computations. 
# It can be used in other ways

print(lars_sponheim)

#==============================================================================#
#
#      #####                     3. Functions                      #####
#
#==============================================================================#

# Functions will do almost anything for you.
# Functions are scripts wrapped up nicely for you into single words.
# log(), exp(), and print() above are examples

# All functions follow the same logic:
# function_name(argument1=, argument2=, ... argumentK=)

# where arguments are options you feed into the function.
# A very common format is function(x, args)
# Where x is an object that you wish to apply the function to.
# Arguments are not always necessary, but most often are.

# To see what options are available, view the functions help page.
# You find the help page by typing ?function_name in your console

# Some simple functions:
mean(my_vector)
min(my_vector)
max(my_vector)
?mean

# one common argument is "na.rm="
# This is often set to FALSE by default, meaning missing values
# are not discarded. This can crash some functions.

# mean(), min() and max() are among the ones who crash, unless 
# we append the argument. Let's try with another vector:

Vector2 <- c(10, 2, 3, NA) # Notice the NA, or missing, value.
mean(Vector2) # simply using mean() won't work (returns NA)
mean(x = Vector2, na.rm = FALSE) # that's because this is the default

# We can tell R to discard any missing values by changing it to TRUE
mean(x = Vector2, na.rm = TRUE)



##  Functions work much like normal maths:
my_vector <- 1:10
mean(my_vector)
mean(ten + my_vector)
mean(ten) + my_vector
mean(my_vector) + ten


##  Some common functions:
median(my_vector)
sum(my_vector)
sd(my_vector)
sqrt(my_vector)
length(my_vector)

#==============================================================================#
#
#     #####                       4. VECTORS                        #####
#
#==============================================================================#


# A vector is a variable
# It's a string of more than one piece of data.

# A vector can only contain elements of the same class. 
# Text and numbers cannot be in the same vector.

# Here are some classes:

##  INTEGER:
IntegerVector <- 1:10
class(IntegerVector)
summary(IntegerVector)

##  NUMERIC:
NumericVector <- 0.5:10
NumericVector
class(NumericVector)
summary(NumericVector)

##  CHARACTER (text):
TextVector <- c("meat", "fish", "vegetarian", "vegetarian", "fish",
                 "vegetarian", "meat", "meat", "fish", "vegetarian")
class(TextVector)
summary(TextVector)
table(TextVector)

##  FACTOR:

FactorVector <- factor(c("Oslo", "Trondheim", "Bergen", "Oslo",
                         "Bergen", "Bergen", "Trondheim", "Bergen",
                         "Trondheim", "Oslo"))

class(FactorVector)
levels(FactorVector) # Possible values - Alphabetically listed
summary(FactorVector)

## LOGICAL:
LogicalVector <- c(TRUE, TRUE, FALSE, TRUE, FALSE,
                  FALSE, TRUE, FALSE, FALSE, FALSE)
class(LogicalVector)



##  If you attempt to combine the classes they will all be forced into the
# lowest level of measurement
eksempel1 <- c("Text", 4, TRUE)

class(eksempel1)
eksempel1


#==============================================================================#
#
#   #####                   5. INDEXING VECTORS                   #####
#
#==============================================================================#


# If you have a vector but you only want a specific value from it
# you can retrieve it by indexing it.

FactorVector
FactorVector[3]
NumericVector
NumericVector[3]
FactorVector[5]
NumericVector[1:5]


# We can also extract by criteria, using which():
NumericVector
NumericVector >= 5 # this returns a logical vector telling us whether
# each part of a vector does or does not meet our criterium.

# Adding a which returns the placement of the parts of the vector that do:
which(NumericVector >= 5)

##  which() can also be put into brackets,
##    returning the values that fulfill the criteria:
NumericVector[which(NumericVector >= 5)]  



# This can also be used for logicals:

which(LogicalVector == FALSE)   

#==============================================================================#
#
#     #####                       6. DATA FRAMES                    #####
#
#==============================================================================#

## A data.frame is a series of vectors put together

# We can bind vectors together in different ways:

# Using data.frame()
dataset <- data.frame(IntegerVector, NumericVector,
                       TextVector, FactorVector,
                       stringsAsFactors = FALSE)
TextVector
class(dataset)
dataset
head(dataset)
names(dataset)
names(dataset) <- c("kids","hours","dinner","city")
names(dataset)

?data.frame


# We can also name our variables directly:
dataset2 <- data.frame(kids = IntegerVector,
                       hours = NumericVector,
                       dinner = TextVector,
                       city = FactorVector,
                        stringsAsFactors = FALSE)
dataset2

##  View() gives a better view than the console
View(dataset2)


# Variablse can be viewed by adding a $ and the var name
dataset2$hours
dataset2$dinner

##  and indexed like any other vector
dataset2$dinner[which(dataset2$dinner == "fish")]
dataset2$hours[which(dataset2$dinner == "fish")]


##  we can index data frames using brackets too
# With more dimensions we need to indicate which dimension we're indexing:
# [row,column]
dataset[3, 4]

dataset[2:5, 3]
dataset2[c(1, 3), c(2, 3)]
##  leaving one side of the comma blank returns all
dataset2[2:5, ]
dataset2[which(dataset2$hours >= 5), ]

# the other side blank returns all variables for the given rows
dataset2[,1:2]


##  We can also use variable names:
dataset[, c("hours", "dinner")]
# note the c() for more than one 


#==============================================================================#
#
#   #####                         7. GRAPHICS                     #####
#
#==============================================================================#

# Simple x,y-plots can be generated with plot()
plot(dataset$hours, dataset$kids)

# Different types are available
plot(dataset$kids, dataset$hours, type="l")
plot(dataset$kids, dataset$hours, type="b")
plot(dataset$kids, dataset$hours, type="c")
plot(dataset$kids, dataset$hours, type="o")
plot(dataset$kids, dataset$hours, type="h")
plot(dataset$kids, dataset$hours, type="s")
plot(dataset$kids, dataset$hours, type="S")

# Shapes and colours can be set
plot(dataset$hours, dataset$kids, pch=1)
plot(dataset$hours, dataset$kids, pch=2)
plot(dataset$hours, dataset$kids, pch=12, col="dodgerblue")


# histograms are also available
histdat <- rnorm(100)
hist(histdat)
# set number of bins - R divides the width of data into this many
hist(histdat, breaks = 25) 
# set cuts at specified points
hist(histdat, breaks = c(min(histdat),-2,-1.5,-1,-0.5,0,0.5,1,1.5,2, max(histdat)))
# bin widths can vary
hist(histdat, breaks = c(min(histdat),-2,-1.5,-1,0,0.5,2, max(histdat)))


# You can also customize the plot with titles and names:
plot(dataset$hours, dataset$kids, pch=12, col="dodgerblue", 
     main="Hællæ", sub = "Put more text down here. Lots of room for describing your graph.",
     xlab= "Hours", ylab="Kids",
     xrange=c(0,10),yrange=c(0,10))

# But if you want nice looking graphs then you should use ggplot (or plotly). 
# We will get to ggplot and advanced graphics later.
#==============================================================================#
#
#   #####                         8. Tabulate                     #####
#
#==============================================================================#


# tabulate using table()
table(dataset$kids)
table(LogicalVector)
table(dataset$city) 
ftable(dataset$city) 

# cross tables by just adding second dimension
table(dataset$dinner, dataset$city)

my_table <- table(dataset$FactorVector, dataset$LogicalVector)

class(my_table)

my_table

# We can use rm() in other ways than clearing everything.
rm(list=ls()) # tells R to remove everything returned by
# the ls() function. The ls() function lists everything
# in your environment. 

# We can also use rm() to do more specific jobs
# First add some objects:

a <- "a"
b <- "b"
c <- "c"

# We can remove everything except a specific object.
# combining setdiff() and ls() lets you define objects to keep:
rm(list=setdiff(ls(), "a"))

# We can also use rm() to remove specific objects:
rm(a)

#==============================================================================#
#                       ### End of introduction ###
#==============================================================================#


