# Tissue-Spray-Code

## Introduction/Motivation
This set of scripts was developed for use in analyzing plant metabolomics. The repo contains an asortment of scripts that were used in conducting analysis around a Tissue Spray experiment using untargeted metabolomics and direct infusion data with no retention times. Recycled some parts from other packages as well which is why some of the code is in python and some in R.

## Usage
Each script can function as a stand alone script so there is no clear workflow. The functionality of each script is described below. 

## Files
A brief description of each file in this repo and its role. 

### compoundcounter.py
Main function is processDuplicates. This function takes a list of files containing the masses (has a column headed 'mzs') of various compounds (typically split into positive or negative mode scans), an output file name, and a list of compounds in the form of a .csv file with 'mzs' as a column header. Writes a csv with the count of each of the compounds from the compound list. 

### direct_infusion_processing.R
Takes a list of files and loops through them, splitting them into positive and negative scans. It then finds the peaks using the centWave method in XCMS, and then trims the results down to a table containing mz, rt, and intensity. It then writes those values to csv files. The second half of the script also allows users to do this analysis with single files. 

### duplicateMZFinder.py
Main function is processDuplicates which takes a list of files containing the masses (has a column headed 'mz') of various compounds (typically split into positive or negative mode scans), and an ouput file name. It reads in the files and outputs every compound and the number of times it occurs. 

### get_mzs.R
Takes a file or list of files and extracts the mz values from that file. Can be written to txt file if desired. 

### VanKrevelen.py and VanKrevelenHeatmap.py
Takes a list of mz values and ouputs either a VanKrevelen scatter plot or heat map. For more detailed information about these scripts, see the VanKrevelen repo in this group. 

## Hegeman Lab - University of Minnesota Twin-Cities
This code was developed for use in the Hegeman Lab at the University of Minnesota Twin-Cities. If you use this script in your research, please don't forget to acknowledge or cite publication. Additionally, if there are any questions about how to use this code, feel free to contact [Adrian Hegeman](mailto:hegem007@umn.edu). 
