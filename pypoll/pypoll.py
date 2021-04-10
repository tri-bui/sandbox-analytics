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
    county_pcts[county] = round(votes / total_votes * 100, 2)

    # Largest county turnout
    if votes > county_most_votes:
        largest, county_most_votes = county, votes


# Initialize a candidate % dict and winning candidate
candi_pcts = dict()
winner, candi_most_votes = '', 0

# Vote % each candidate received
for candi, votes in candi_cnts.items():
    candi_pcts[candi] = round(votes / total_votes * 100, 2)

    # Winner
    if votes > candi_most_votes:
        winner, candi_most_votes = candi, votes


""" Write Results to File """

def write_hr(file, n=1):

    """ Write a horizontal rule to the output file n number of times. """

    for i in range(n):
        file.write('----------------------------------------------\n')


# Write to file
with open(analysis_path, 'w') as write_file:
    write_file.write('\nElection Results\n')
    write_hr(write_file)
    write_file.write(f'Total votes: {total_votes:,}\n')
    write_hr(write_file, 2)

    # Vote count for each county
    write_file.write('\nCounties\n')
    write_hr(write_file)
    for county, votes in county_cnts.items():
        write_file.write(f'{county} County: {votes:,} votes ({county_pcts[county]}%)\n')
    write_hr(write_file)

    # Largest county turnout
    write_file.write(f'Largest County Turnout: {largest}\n')
    write_file.write(f'Votes: {county_most_votes:,} ({county_pcts[largest]}%)\n')
    write_hr(write_file, 2)

    # Election winner
    write_file.write('\nCandidates\n')
    write_hr(write_file)
    for candi, votes in candi_cnts.items():
        write_file.write(f'{candi}: {votes:,} votes ({candi_pcts[candi]}%)\n')
    write_hr(write_file, 1)

    write_file.write(f'Winner: {winner}\n')
    write_file.write(f'Votes: {candi_most_votes:,} ({candi_pcts[winner]}%)\n')
    write_hr(write_file, 2)