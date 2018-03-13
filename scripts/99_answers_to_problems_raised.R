# How to get proportions in a crosstable?

# Solution 1: divide by nobs in data (we can easily find number of obs using nrow())
table(bakeries$cake, bakeries$croissant) / nrow(bakeries)

# Solution 2: Use prop.table() on a store table
mytable <- table(bakeries$cake, bakeries$croissant)
prop.table(mytable)

# Solution 3: xtabs() and divide. Just another function with slightly different syntax
xtabs(~croissant + donut, data=bakeries) / nrow(bakeries)

# How to plot names for all your dots in geom_point?
ggplot(mtcars, aes(x= disp, y= hp, label=rownames(mtcars)))+
  geom_point() +geom_text(aes(label=rownames(mtcars)), hjust = 0, vjust= 0) +
  theme_bw()

# Lots of options to play with: ?geom_text