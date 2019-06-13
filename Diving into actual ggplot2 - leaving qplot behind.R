
#  Diving into actual ggplot2 - leaving qplot behind.

library(ggplot2)
data(diamonds)



ggplot(dsmall, aes(x=carat, y=price)) 

+geom_point()
  +  geom_smooth(stat="smooth")


