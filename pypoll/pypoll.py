# Dependencies
import os
import csv


""" Read Data and Get Counts """

# File paths
os.makedirs('analysis', exist_ok=True) # create analysis folder for write file
analysis_path = os.path.join('analysis', 'results.txt') # path of file to write to
data_path = os.path.join('data', 'election_results.csv') # path of file to read


# Read file
with open(data_path, 'r') as read_file:
    data = csv.reader(read_file) # csv reader
    columns = next(data) # skip header row

    # Initialize a list and count dict for cols 1 and 2
    counties, candidates = [], []
    county_cnts, candi_cnts = dict(), dict()

    # Store each col
    for row in data:
        county, candidate = row[1:] # extract cols 1 and 2
        counties.append(county) # country
        candidates.append(candidate) # candidate

        # Accumulate county counts
        if county not in county_cnts:
            county_cnts[county] = 1
        else:
            county_cnts[county] += 1
        
        # Accumulate candidate counts
        if candidate not in candi_cnts:
            candi_cnts[candidate] = 1
        else:
            candi_cnts[candidate] += 1


""" Calculate Vote % and Get Highest Counts """

# Total votes
total_votes = len(candidates)


# Initialize a county % dict and largest county turnout
county_pcts = dict()
largest, county_most_votes = '', 0

# Vote % from each county
for county, votes in county_cnts.items():
    county_pcts[county] = votes / total_votes * 100

    # Largest county turnout
    if votes > county_most_votes:
        largest, county_most_votes = county, votes


# Initialize a candidate % dict and winning candidate
candi_pcts = dict()
winner, candi_most_votes = '', 0

# Vote % each candidate received
for candi, votes in candi_cnts.items():
    candi_pcts[candi] = votes / total_votes * 100

    # Winner
    if votes > candi_most_votes:
        winner, candi_most_votes = candi, votes


""" Write Results to File """

# Horizontal rule and spaceswith pipes
h = '|' + ('-' * 50) + '\n' # pipe + horizontal rule + newline
s = '|' + (' ' * 2) # pipe + 2 spaces

# Title and total votes
heading = (
    f'{h}' + f'{s}Election Results\n' + f'{h}' # line + title + line
    f'{s}Total votes: {total_votes:,}\n' + f'{h * 3}' # total votes + 3 lines
)

# Vote count for each county
county_votes = f'{s}Counties\n' + f'{h}' # county heading + line
for county, votes in county_cnts.items():
    county_votes += f'{s}{county} County: {votes:,} votes ({county_pcts[county]:.2f}%)\n'

# Largest county turnout
largest_turnout = (
    f'{h}' + f'{s}Largest Turnout: {largest} County\n' # line + largest county turnout
    f'{s}Votes: {county_most_votes:,} ({county_pcts[largest]:.2f}%)\n' + f'{h * 3}' # vote count + 3 lines
)

# Vote count for each candidate
candidate_votes = f'{s}Candidates\n' + f'{h}' # candidate heading + line
for candi, votes in candi_cnts.items():
    candidate_votes += f'{s}{candi}: {votes:,} votes ({candi_pcts[candi]:.2f}%)\n'

# Election winner
election_winner = (
    f'{h}' + f'{s}Winner: {winner}\n' # line + election winner
    f'{s}Votes: {candi_most_votes:,} ({candi_pcts[winner]:.2f}%)\n' + f'{h * 2}' # vote count + 2 lines
)


# Print results
print(heading + county_votes + largest_turnout + candidate_votes + election_winner)

# Write to file
with open(analysis_path, 'w') as write_file:
    write_file.write(heading) # title and total votes
    write_file.write(county_votes) # vote counts for each county
    write_file.write(largest_turnout) # largest county turnout
    write_file.write(candidate_votes) # vote counts for each candidate
    write_file.write(election_winner) # election winner