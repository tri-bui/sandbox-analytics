### Dependencies and Data ###

# Libraries
# install.packages('tidyverse')
library(tidyverse)
library(jsonlite)

# Read in CSV files
demo_csv <- read.csv(file = 'demo/data/demo.csv',
                     stringsAsFactors = F)
demo_wide <- read.csv(file = 'demo/data/demo2.csv',
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

# Melt a wide dataframe into a long one
long_demo <- gather(demo_wide, key = 'Metric', value = 'Score',
                    2:ncol(demo_wide))

# Unstack the long df back into a wide one (using piping)
wide_demo <- long_demo %>% spread(key = 'Metric', 
                                  value = 'Score', 
                                  fill = 0)

# Check if the unstacked df equals the original imported one
# Optionally sort the columns for both dfs before the check
print(all.equal(demo_wide[, order(colnames(demo_wide))], 
                wide_demo[, order(colnames(wide_demo))]))
