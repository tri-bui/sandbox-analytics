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


### Box plots ###

# Single box plot
box1 <- ggplot(mpg_data, aes(y = hwy))
box1 + geom_boxplot(color = 'red', linetype = 'dashed') + 
       labs(title = 'Highway MPG', 
            y = 'Highway Fuel Economy (MPG)')

# Grouped box plots with points
box2 <- ggplot(mpg_data, aes(x = manufacturer, y = hwy))
box2 + geom_boxplot() + geom_point() + 
       labs(title = 'Highway MPG by Mannufacturer', 
            x = 'Manufacturer', 
            y = 'Highway Fuel Economy (MPG)') + 
       theme(axis.text.x = element_text(angle = 45, 
                                        hjust = 1))


### Heatmaps ###

# Calculate the highway MPG grouped by manufacturer and year
grouped_mpg <- mpg_data %>% 
                 group_by(manufacturer, year) %>%
                 summarize(mean_hwy = mean(hwy), 
                           .groups = 'keep')

# Heatmap
heat1 <- ggplot(grouped_mpg, aes(x = manufacturer, 
                                 y = factor(year), 
                                 fill = mean_hwy))
heat1 + geom_tile() + 
        labs(title = 'MPG by Manufacturer and Year', 
             x = 'Manufacturer', y = 'Year', 
             fill = 'Highway MPG') + 
        theme(axis.text.x = element_text(angle = 90, 
                                         hjust = 1, 
                                         vjust = 0.5))


### Error bars ###

# Calculate the mean engine size by class
class_disp <- mpg_data %>% group_by(class) %>% 
                           summarize(mean_disp = mean(displ),
                                     sd_disp = sd(displ))

# Point plot with error bars
error1 <- ggplot(class_disp, aes(x = class, y = mean_disp))
error1 + geom_point(size=4) + 
         geom_errorbar(aes(ymin = mean_disp - sd_disp, 
                           ymax = mean_disp + sd_disp)) +
         labs(title = 'Engine Size by Vehicle Class', 
              x = 'Class', y = 'Engine Size (L)')


### Faceting ###

# Gather MPG columns into the long format
mpg_long <- mpg_data %>% gather(key = 'mpg_type', 
                                value = 'mpg_rating', 
                                c(cty, hwy))

# Non-faceted box plot
facet1 <- ggplot(mpg_long, aes(x = manufacturer, 
                               y = mpg_rating, 
                               color = mpg_type))
facet1 + geom_boxplot() + 
         labs(title = 'MPG by Manufacturer', 
              x = 'Manufacturer', y = 'MPG', 
              color = 'MPG Type') + 
         theme(axis.text.x = element_text(angle = 45, 
                                          hjust = 1))

# Faceted box plot
facet2 <- ggplot(mpg_long, aes(x = manufacturer, 
                               y = mpg_rating, 
                               color = mpg_type))
f_labs <- c('cty' = 'City', 'hwy' = 'Highway') # facet labels
facet2 + geom_boxplot() + 
         facet_wrap(vars(mpg_type), 
                    labeller = labeller(mpg_type = f_labs)) + 
         labs(title = 'MPG by Manufacturer', 
              x = 'Manufacturer', y = 'MPG') + 
         theme(legend.position = 'none',
               axis.text.x = element_text(angle = 90, 
                                         hjust = 1, 
                                         vjust = 0.5))