#==============================================================================#
# #4 - graphics - scatterplots
#
#==============================================================================#
#==============================================================================#

# For this graphics guide we will be using ggplot. ggplot is great system for
# graphing simple and complex data from one or more sources. It supports a wide
# range of graphs, and has a great library of colours and styles.
# This script will concentrate on the scatter plot, but you will find most of 
# what is covered here useful when doing other plot types later.

# install.packages("ggplot2")
library(ggplot2)

#==============================================================================#

# Packages  = ggplot2
# Functions = ggplot(), geom_point(), and lots of additional features.

# plot() simply needs directions to two variables to create a plot. ggplot needs
# you to first create a ggplot object containing the data you wish to use in 
# your graph. This object can then be used to draw a wide range of plots.

#==============================================================================#

# Before we start: Clean
rm(list=ls())

# And remember to set your working directory
setwd("C:/Users/martism/Dropbox/NTNU/Undervisning/R/ISS-R")

#==============================================================================#

# First we load some data
data(mtcars)

# We then create our ggplot object
scatterplot <- ggplot(mtcars, aes(x = disp, y = hp))

# If we access the object now it gives us a blank plot
# with the axes defined when we made the object.
scatterplot

# To get more info we need to add layers
scatterplot + geom_point()

# You can either create an object and plot by adding layers, or you can simply 
# put everything straight into one command. The latter produces the plot
# immediately, and so it's nicer to work with when exploring your plot.

ggplot(mtcars, aes(x = disp, y = hp))  +
  geom_point()

                            #### Shapes ####

# We can define the shape of our points using shape:
ggplot(mtcars, aes(x = disp, y = hp))  +
  geom_point(shape = 1)

ggplot(mtcars, aes(x = disp, y = hp))  +
  geom_point(shape = 2)

ggplot(mtcars, aes(x = disp, y = hp))  +
  geom_point(shape = 3)


# We can also give groups different shapes based on a var:
ggplot(mtcars, aes(x = mpg, y = hp))  +
  geom_point(color = "dodgerblue", aes(shape = as.factor(cyl)))

# We can do the same with colours:
ggplot(mtcars, aes(x = mpg, y = hp))  +
  geom_point(shape = 3, aes(color = disp))

# Or both:
ggplot(mtcars, aes(x = mpg, y = hp))  +
  geom_point(aes(color = disp, shape = as.factor(gear)))

# size can also be used as an option 
ggplot(mtcars, aes(x = mpg, y = hp))  +
  geom_point(aes(size = qsec))

# or opacity, using alpha
ggplot(mtcars, aes(x = mpg, y = hp))  +
  geom_point(aes(alpha = as.factor(cyl)))

# Or all four!
ggplot(mtcars, aes(x = mpg, y = hp))  +
  geom_point(aes(color = disp,
                 shape = as.factor(gear),
                 size = qsec,
                 alpha = as.factor(cyl)))

# Extra layers can be added using +, and from here I'll be storing each
# new line into the object to save space and focus on what's new.
# Let's store what we have:
myplot <- ggplot(mtcars, aes(x = mpg, y = hp))  +
  geom_point(aes(color = disp,
                 shape = as.factor(gear),
                 size = qsec,
                 alpha = as.factor(cyl)))
myplot

# You can add regression lines using geom_smooth()
myplot <-myplot  +
  geom_smooth(method = "lm")
myplot
# Test your own: see what happens if you don't specify method

# Add horizontal lines with geom_hline()
myplot + 
  geom_hline(yintercept = mean(mtcars$hp))

# and vertical lines with geom_vline()
myplot + 
  geom_vline(xintercept = mean(mtcars$mpg))

# we can add more lines, and colour them too
myplot <- myplot + 
  geom_hline(yintercept = mean(mtcars$hp), alpha = 0.3, color = "orange") +
  geom_vline(xintercept = mean(mtcars$mpg), alpha = 0.3, color = "orange") +
  geom_hline(yintercept = 0)
myplot

# We can draw in rectangles, lines, and text using annotate()
# Text is text, segment is line, rect is rectangle
myplot <- myplot + 
  annotate("text", label = "Outlier", x = 18, y = 335, size = 4,
           colour = "dodgerblue") +
  annotate("text", label = "Not outliers", x = 25, y = 250, size = 4,
           colour = "black") +
  annotate("segment", x = 17, xend = 22, y = 250, yend = 250, colour = "black") +
  annotate("rect", xmin = 12, xmax = 17, ymin = 220, ymax = 280, alpha = .2)
myplot

# If you for some reason, maybe comparison, need to change the x,y coverage,
# use xlim/ylim
myplot <- myplot + 
  xlim(9,34)+
  ylim(0,350)
myplot

# Looking good! Time to clean up around the plot. 
# Add titles and labels using labs:
myplot <- myplot + 
  labs(y="Horsepower", x="Miles per gallon", title="mtcars plot")
myplot

# Now for the legends. We mapped gears to shapes, so to change the legend
# we use scale_shape_discrete.
myplot <- myplot + 
  scale_shape_discrete(name="Gears", labels=c("3", "4", "5"))
myplot

# qsec is mapped to color, but it is continous, not discrete.  
# scale_color_continous it is
myplot <- myplot + 
  scale_color_gradient(name="Displacement",
                       low = "dodgerblue",
                       high = "springgreen")
myplot

# na.value = "black" # this sets the color for units with missing
# on the var color is supposed to vary on.

# we also mapped discrete values to alpha
myplot <- myplot + 
  scale_alpha_discrete(name = "Cylinders", labels = c("4","6","8"))
myplot

# we also mapped discrete values and to size
myplot <- myplot + 
  scale_size(name = "Qsec")
myplot

# Approaching perfection. Just one more thing...
myplot <- myplot + 
  theme_bw()
myplot

# There we go. Now let's see all of that at once:

ggplot(mtcars, aes(x = mpg, y = hp))  +
  geom_point(aes(color = disp,
                 shape = as.factor(gear),
                 size = qsec,
                 alpha = as.factor(cyl))) +
  geom_smooth(method = "lm") +
  geom_hline(yintercept = mean(mtcars$hp), alpha = 0.3, color = "orange") +
  geom_vline(xintercept = mean(mtcars$mpg), alpha = 0.3, color = "orange") +
  geom_hline(yintercept = 0) +
  annotate("text", label = "Outlier", x = 18, y = 335, size = 4,
           colour = "dodgerblue") +
  annotate("text", label = "Not outliers", x = 25, y = 250, size = 4,
           colour = "black") +
  annotate("segment", x = 17, xend = 22, y = 250, yend = 250, colour = "black") +
  annotate("rect", xmin = 12, xmax = 17, ymin = 220, ymax = 280, alpha = .2) +
  xlim(9,34) +
  ylim(0,350) +
  labs(y="Horsepower", x="Miles per gallon", title="mtcars plot") +
  scale_shape_discrete(name="Gears", labels=c("3", "4", "5")) +
  scale_color_gradient(name="Displacement",
                       low = "dodgerblue", high = "springgreen") +
  scale_alpha_discrete(name = "Cylinders", labels = c("4","6","8")) +
  scale_size(name = "Qsec") +
  theme_bw() 



#==============================================================================#
#                        #### Saving your plot ####

# ggsave will save your plot for you. Specify file path and name (both go in the
# "filename" argument), which plot to save (if none is specified the last plot will be 
# saved), size and units of size.
ggsave(filename = "mtcarsplot.jpg", 
       plot = myplot,
       width = 150, 
       height = 150, 
       units ="mm")


#==============================================================================#

# Figure showing all possible shapes:
d=data.frame(p=c(0:25,32:127))
ggplot() +
  scale_y_continuous(name="") +
  scale_x_continuous(name="") +
  scale_shape_identity() +
  geom_point(data=d, mapping=aes(x=p%%16, y=p%/%16, shape=p), size=5, fill="red") +
  geom_text(data=d, mapping=aes(x=p%%16, y=p%/%16+0.25, label=p), size=3)


#                               #### End ####
#==============================================================================#
#==============================================================================#
#==============================================================================#
