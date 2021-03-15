### Dependencies and Data ###

# Libraries
library(tidyverse)
library(jsonlite)

# Built-in mpg data
mpg_data <- mpg


### Bar plots ###

# Bar plot for category counts
bar1 <- ggplot(mpg, aes(x = manufacturer))
bar1 + geom_bar() + ggtitle('Vehicles by Manufacturer') + 
       xlab('Manufacturer') + ylab('Number of Vehicles') +
       theme(axis.text.x = element_text(angle = 45, 
                                        hjust = 1))

# Calculate the mean mpg for each class
manu_mpg <- mpg_data %>% group_by(manufacturer) %>% 
                          summarize(mean_hwy = mean(hwy))

# Bar plot for a different metric
bar2 <- ggplot(manu_mpg, aes(x = manufacturer, y = mean_hwy))
bar2 + geom_col() + ggtitle('Average MPG by Manufacturer') + 
       xlab('Manufacturer') + 
       ylab('Average Fuel Economy (MPG)') + 
       theme(axis.text.x = element_text(angle = 45, 
                                        hjust = 1))


### Line plots ###

# Calculate the mean mpg by cylinder count for Toyota cars
toyota_mpg <- mpg_data %>% 
                subset(manufacturer == 'toyota') %>% 
                group_by(cyl) %>% 
                summarize(mean_hwy = mean(hwy))

# Line plot
line1 <- ggplot(toyota_mpg, aes(x = cyl, y = mean_hwy))
line1 + geom_line() + ggtitle('Average MPG of Toyota Cars') + 
        xlab('Number of Cylinders') + 
        ylab('Average Fuel Economy (MPG)') + 
        scale_x_discrete(limits = c(4, 6, 8)) + 
        scale_y_continuous(breaks = 15:30)


### Scatter plots ###

# Scatter plot
scatter1 <- ggplot(mpg_data, aes(x = displ, y = hwy, 
                                 size = cty, color = class))
scatter1 + geom_point(alpha = 0.8) + 
           labs(title = 'MPG by Engine Size', 
                x = 'Engine Size (L)', 
                y = 'Highway Fuel Economy (MPG)', 
                size = 'City MPG', 
                color = 'Vehicle Class')

