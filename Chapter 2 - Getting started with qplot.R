# This is working through Chapter 2 of 'ggplot2', the book by Hadley Wickham.

#####  Chapter 2 - Getting started with qplot - using two data sets, 
#      diamonds (53940 obs) and dsmall (100 obs)

library(ggplot2)
data(diamonds)


set.seed(1410) # Make the sample reproducible

dsmall <-diamonds[sample(nrow(diamonds),100),]

#### 2.3 - basic use - the first two arguments are X and Y, to give the X and Y coordinates;
#### the data argument is optional, but really, really recommended.

qplot(carat, price, data=diamonds)  # note the clustering in X around the integers for carat.

# try using logs:

qplot(log(carat), log(price), data=diamonds)

# you can use combinations of variables as arguments - thi plots the volume (=x*y*z)
# vs the weight.

qplot(carat, x*y*z, data=diamonds) # there is the expected linear relationship, 
                                   # along with some outliers.



######## 2.4 - Colour, size, shape and other aesthetic attributes.

# The base plot command requires direct listings of colours, etc. 
# IOW, you can't enter a categorical variable, and have the plot command select colors.
# You *can* have qplot do this, and for other aesthetics.


qplot(carat, price, data=dsmall, colour=color)

qplot(carat, price, data=dsmall, shape=cut)

qplot(carat, price, data=dsmall,  colour=color, shape=cut)

# Colour, size and shape are all examples of aesthetic attributes.
# For every aesthetic attribute, there is a function, called a scale, 
# which maps data values to valid values for that aesthetic.

# You can manually set the aesthetics using I().
# Examples:  colour=I("red"), size=I(2).  This inot the same as mapping (see 4.5.2).

# One useful aesthetic for large datasets is semi-transparency, which allows overplotting
# without overwriting points.  This is done by setting the alpha aesthetic, from 0 to 1.
# If you use fractions (e.g., 1/5), the denominator specifies how many points have to 
# overlap for complete opacity.

qplot(carat, price, data=diamonds, alpha=I(1/10), main="Alpha=I(1/10)")
qplot(carat, price, data=diamonds, alpha=I(1/100), main="Alpha=I(1/100)")
qplot(carat, price, data=diamonds, alpha=I(1/200), main="Alpha=I(1/200)")


#### 2.5 Plot geoms.

# Geoms are 'geometric objects', any object used to display the data.
# For example a histogram is a binning statistic plus a bar geom.

# The default is geom="point", where a point is place on each coordinate.

# Others are "boxplot", "smooth", "line" (connects points from left to right),
# "path" (connects points any direction). 

# For continuous variables: "histogram", "freqpoly" (frequency polygon),
# "density (density plot)

# For discrete variables, "bar" makes a bar chart.

# 2.5.1 - Adding a Smoother to a Plot (note that the default is loess)

qplot(carat, price, data=dsmall,  colour=color, geom="smooth") # groups by colour
qplot(carat, price, data=dsmall,  geom="smooth" ) # both of these don't plot the points.

qplot(carat, price, data=dsmall, geom=c("smooth","point")) # plots both


qplot(carat, price, data = dsmall, geom = c("point", "smooth"), span = 1)
qplot(carat, price, data=dsmall, geom=c("smooth","point"), span=0.2) # adjust the window

# The span command does not work with qplot - the help for qplot does not include the word
# 'span'.  

ggplot(dsmall, aes(x=carat, y=price)) + 
  geom_point()+
+  geom_smooth(span=0.2)
