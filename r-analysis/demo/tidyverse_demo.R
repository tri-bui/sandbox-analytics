### Dependencies and Data ###

# Libraries
install.packages('tidyverse') # install lib
library(tidyverse) # import lib

# Read in CSV file
demo_csv <- read.csv(file = 'data/demo.csv',
                     stringsAsFactors = F)


### Transformations ###

# Add new columns
demo_csv <- demo_csv %>% mutate(Mileage_per_Year = Total_Miles / (2021 - Year), Is_Active = TRUE)