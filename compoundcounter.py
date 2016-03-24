'''
Reads in csv of mzs, outputs how many times the mzs
were present in a number of input files
'''


# import packages. csv is standard package and pandas is widely used and part of Anaconda packages
import csv
import pandas as pd


# short helper to pass into map. Takes number and rounds to 3 decimal places
def roundto4(x):
    return round(x, 4)


# Takes list of values and returns the unique m/z values and their counts
def finder(in_list, compounds):

    # Rounds each value in each list of mzs (1 list per file input)
    for i in range(len(in_list)):
        in_list[i] = map(roundto4, in_list[i])

    # Rounds compounds to 4 digits (even if entered as 4 digits sometimes exact values not passed through)
    compounds = map(roundto4, compounds)

    # Sets up helper lists
    counts = [0] * len(compounds)
    checked = [0] * len(compounds)

    # For each unique m/z, get a count of how many times it appears
    # NOTE, assumes input csv of compounds is sorted

    # for each compound of interest
    for x in compounds:
        # check in each of the files
        for i in in_list:
            # and if found, add to the count.
            if x in i:
                index = compounds.index(x)
                if checked[index] == 0:
                    counts[index] += 1
                # Handles when an m/z is in the compound list twice to get around python's .index() function
                else:
                    counts[index + checked[index]] += 1
        checked[compounds.index(x)] += 1

    return [compounds, counts]


# Takes a list containing two lists of equal lengths and writes them to
# a csv (need to have .csv in filename
def writeToCSV(mzs_and_counts, output_filename):
    with open(output_filename, 'wb') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['mzs', 'count'])
        for x in range(0, len(mzs_and_counts[1])):
            writer.writerow([mzs_and_counts[0][x], mzs_and_counts[1][x]])


# Reads in mz values from a file and returns list of mzs
def readFromCSV(filename):
    df = pd.read_csv(filename)
    return list(df['mzs']) # Make sure file has a column named mzs


# Compound file must have mz as column header
def processDuplicates(files_list, outputname, compound_file):
    mzs = []
    compounds = readFromCSV(compound_file)
    for f in files_list:
        mzs.append(readFromCSV(f))
    writeToCSV(finder(mzs, compounds), outputname)


# Example use
nfiles = [
    "Tri4_25-neg.csv",
    "Tri3_25-neg.csv",
    "Tri5_25-neg.csv",
    "Tri6_25-neg.csv",
    "Tri7_25-neg.csv",
    "Tri8_25-neg.csv"
]

pfiles = [
    "Tri4_25-pos.csv",
    "Tri3_25-pos.csv",
    "Tri5_25-pos.csv",
    "Tri6_25-pos.csv",
    "Tri7_25-pos.csv",
    "Tri8_25-pos.csv"
]

compoundfilep = "GLexactmasses-pos.csv"
compoundfilen = "GLexactmasses-neg.csv"

processDuplicates(nfiles, 'Tri-neg-compounds.csv', compoundfilen)
processDuplicates(pfiles, 'Tri-pos-compounds.csv', compoundfilep)

print('compounds have been compared... BOOM')




