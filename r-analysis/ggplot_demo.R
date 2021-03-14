### Dependencies and Data ###

# Libraries
library(tidyverse)
library(jsonlite)

# Built-in mpg data
mpg_data <- mpg


### Bar plots ###

# Bar plot
bar_plt <- ggplot(mpg, aes(x = class))
bar_plt + geom_bar()

# Count cars from each class
manu_count <- mpg_data %>% group_by(class) %>% 
                           summarize(n_cars = n())

# Same bar plot using 2 variables
bar_plt <- ggplot(manu_count, aes(x = class, y = n_cars))
bar_plt + geom_col()