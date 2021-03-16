### Dependencies and Data ###

# Libraries
# install.packages('jsonlite') # install lib
library(jsonlite) # import lib

# Read in CSV file (df 1)
demo_csv <- read.csv(file = 'data/demo.csv',
                 check.names = F,
                 stringsAsFactors = F)

# Read in JSON file (df 2)
demo_json <- fromJSON(txt = 'data/demo.json')


### Selecting Data ###

# Print the 1st cell (row 1, col 1) of each df
print(demo_csv[1, 'Name']) # using col name
print(demo_json[1, 1]) # using col index

# Select the name column in df 1
names <- demo_csv$Name
print(names[2]) # print the 2nd name

# Check if the names contain "Bob"
print('Bob' %in% names)


### Filtering Data ###

# Filter for rows in df 2 where the price > 10000
gt10k <- demo_json[demo_json$price > 10000,]

# Filter for names in df 1 where the year > 2015
name05 <- subset(x = demo_csv, 
                 subset = demo_csv$Year > 2015, 
                 select = 'Name')

# Filter for rows in df 2 using 3 conditions
filtered <- subset(demo_json, 
                   price > 10000 
                    & drive == "4wd" 
                    & "clean" %in% title_status)


### Sampling ###

# Sample 2 items from a vector
v <- 1:10 # create vector
s <- sample(v, 2)

# Sample 2 rows from df 2
idx <- 1:nrow(demo_json) # create vector for row indices
row_samp <- sample(idx, 2) # sample 2 indices
samp <- demo_json[row_samp,] # filter for selected indices

# Reduce to 1 line
samp <- demo_json[sample(1:nrow(demo_json), 2),]