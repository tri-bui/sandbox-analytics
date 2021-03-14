### Dependencies and Data ###

# Libraries
# install.packages('tidyverse')
library(tidyverse)
library(jsonlite)

# Read in CSV files
demo_csv <- read.csv(file = 'demo/data/demo.csv',
                     stringsAsFactors = F)
demo2_csv <- read.csv(file = 'demo/data/demo2.csv',
                     stringsAsFactors = F)

# Read in JSON file
demo_json <- fromJSON(txt = 'demo/data/demo.json')


### Transformations ###

# Add new columns
demo_csv <- demo_csv %>% 
              mutate(Mileage_per_Year = Total_Miles / (2021 - Year), 
                     Is_Active = TRUE)

# Aggregate by groups
cond_agg <- demo_json %>% 
              group_by(condition) %>% 
              summarize(n_cars = n(), 
                        avg_price = mean(price), 
                        min_mileage = min(odometer))


