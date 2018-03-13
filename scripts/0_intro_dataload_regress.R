
#==============================================================================#

# Before we start learning the basics, let us see how easy it
# can be to load data into R and run regressions.

#==============================================================================#

# You can load data into RStudio by clicking on the "Open file" or
# "Import Dataset" buttons in your environment tab.
# Please don't do this. (And if you do: Copy-paste the code it gives
# you into your script so you keep things reproducible.)

# What you should do is write a line of code. This follows a simple
# format: command(file)

# We use different commands, or functions, for different formats.
# Each function is merely a redirect to further script, and these
# are customized to read certain file formats.

#==============================================================================#

#                       #### Loading data ####

#==============================================================================#

# To read .csv-files use read.csv()

avengers <- read.csv("data/avengers.csv")

#==============================================================================#
#                       #### Some light regression ####

# let's see if the gender and time in the avengers has any effect 
# on the number of appearances in stories. The lm() function is 
# equivalent to reg in Stata:

# reg y x1 x2##x3 x4##x4
# is equivalent to
# lm(y ~ x1 + x2 * x3 + poly(x4,2), data=data)

# interactions and polynomials are easily included.

# Example using Avengers:
lm(appearances ~ gender + years_since_joining, data = avengers)

# You will see that the results are somewhat unsatisfying.
# We only get coefficients in the console, with no further
# information about our model.

# To get more info, we can store our model:
m1 <- lm(appearances ~ gender + years_since_joining, data = avengers)
# And then use summary() to extract more info:
summary(m1)
# Here you find most of what you need. More info can also be extracted, but
# we'll get to that later.

#==============================================================================#

# Once we have model objects we can easily extract fancy, journal ready tables:
install.packages("stargazer")
library(stargazer)
# The basic function
stargazer(m1, type="text")
# With some adjustments
stargazer(m1, type="text", column.labels = "Apps.",
          dep.var.caption = "OLS",dep.var.labels = "",
          digits = 2, omit.stat = c("rsq","f", "ser"),
          keep = c("genderMALE", "years_since_joining"),
          single.row = T, covariate.labels = c("Male", "Years active"))


#==============================================================================#
# So once you know what you need you can read data, run models,
# and have a nice table in just a few lines:

avengers <- read.csv("data/avengers.csv")

m1 <- lm(appearances ~ years_since_joining, data = avengers)
m2 <- lm(appearances ~ gender + years_since_joining, data = avengers)

stargazer(m1, m2, type="text", column.labels = c("Apps.", "Apps."),
          dep.var.caption = "OLS",dep.var.labels = "",
          digits = 2, omit.stat = c("rsq","f", "ser"),
          keep = c("genderMALE", "years_since_joining"),
          single.row = F, covariate.labels = c("Male", "Years active"))

#==============================================================================#
#==============================================================================#

