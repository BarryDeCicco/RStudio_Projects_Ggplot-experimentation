# This is from: https://hopstat.wordpress.com/2016/02/18/how-i-build-up-a-ggplot2-figure/
# I've tried these commands, and THEY WORK!

library(ggplot2)
ggplot(data = quakes, aes(x = lat,y = long,colour = stations)) + geom_point()

g = ggplot(data = quakes,
           aes(x = lat,y = long,colour = stations)) +
  geom_point()

print(g)

gbig <- g + theme(axis.text = element_text(size = 18),
                axis.title = element_text(size = 20),
                legend.text = element_text(size = 15),
                legend.title = element_text(size = 15))

gbig

gbig <- gbig + xlab("Latitude") + ylab("Longitude")
gbig

gbig <-gbig + ggtitle("Spatial Distribution of Stations")

gbig <- gbig +
  ggtitle("Spatial Distribution of Stations") +
  theme(title = element_text(size = 30))

gbig

gbig <- gbig +   theme(title = element_text(size = 20))
gbig


gbigleg_orig = gbig + guides(colour = guide_colorbar(title = "Number of Stations Reporting"))
gbigleg_orig

gbigleg = gbig + guides(colour = guide_colorbar(title = "Number\nof\nStations\nReporting"))
gbigleg

gbigleg = gbigleg +
  guides(colour = guide_colorbar(title = "Number\nof\nStations\nReporting",
                                 title.hjust = 0.5))
gbigleg

gbigleg = gbigleg +
  theme(legend.position = c(0.30, 0.30))

gbigleg

# the author wrote a helper function:

transparent_legend =  theme(
  legend.background = element_rect(fill = "transparent"),
  legend.key = element_rect(fill = "transparent",
                            color = "transparent")
)

gbigleg = gbigleg + transparent_legend
gbigleg = gbigleg +
  theme(legend.position = c(0.10, 0.30))

gbigleg


