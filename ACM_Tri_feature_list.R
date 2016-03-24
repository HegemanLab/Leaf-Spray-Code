# Used for MS data with no retention times such as Direct Infusion data. 

# import XCMS provided by Bioconductor. 
library(xcms)

# Need to set working directory first! use getwd() to check current 
# directory and then if needed, use setwd() and set your working directory
setwd("C:/Users/Lab/Desktop")

### MULTIPLE FILE PROCESSING

# input filenames as a list. Each element must be in quotes (as a string)
input_filenames <- c(
  "Tri3_25.mzXML",
  "Tri4_25.mzXML",
  "Tri5_25.mzXML",
  "Tri6_25.mzXML",
  "Tri7_25.mzXML",
  "Tri8_25.mzXML"
)

# input_filenames <- c(
#   "ACM_Feb6_244.mzXML",
#   "ACM_Feb6_268.mzXML",
#   "ACM_Feb6_277.mzXML",
#   "ACM_Feb6_B2_255.mzXML",
#   "ACM_Feb6_B2_274.mzXML",
#   "ACM_Feb6_B3_270.mzXML"
# )


# 'loops' through the filenames 
lapply(input_filenames, function(x){
  
  input_filename <- x
  
  # Creates a xcmsRaw object
  xraw <- xcmsRaw(input_filename)
  
  # Splits it according to polarity
  xraw_pos <- split(xraw, xraw@polarity == "positive")
  
  pos_data <- xraw_pos$'TRUE'
  neg_data <- xraw_pos$'FALSE'
  
  # Finds peaks for positive and negative scans
  found_pos <- findPeaks.centWave(pos_data, ppm = 3, peakwidth=c(5,50), snthresh=50, mzdiff=0.01, prefilter=c(3,1500000))
  found_neg <- findPeaks.centWave(neg_data, ppm = 3, peakwidth=c(5,50), snthresh=50, mzdiff=0.01, prefilter=c(3,1500000)) 
  
  # cuts out data that isn't needed 
  trim_pos <- cbind(found_pos@.Data[,1], found_pos@.Data[,4], found_pos@.Data[,7])
  colnames(trim_pos) <- c("mz", "rt", "intensity")
  
  trim_neg <- cbind(found_neg@.Data[,1], found_neg@.Data[,4], found_neg@.Data[,7])
  colnames(trim_neg) <- c("mz", "rt", "intensity")
  
  # outputs CSVs
  write.csv(trim_pos, file = paste("pos-", substr(input_filename, 1, nchar(input_filename)-6), ".csv", sep = ""), row.names = F)
  write.csv(trim_neg, file = paste("neg-", substr(input_filename, 1, nchar(input_filename)-6), ".csv", sep = ""), row.names = F)
  
})

# Input file goes here.
input_filename <- "ACM_Feb6_244.mzXML"

# Creates a xcmsRaw object
xraw <- xcmsRaw(input_filename)

# Splits it according to polarity
xraw_pos <- split(xraw, xraw@polarity == "positive")

pos_data <- xraw_pos$'TRUE'
neg_data <- xraw_pos$'FALSE'

# Finds peaks for positive and negative scans
found_pos <- findPeaks.centWave(pos_data, ppm = 3, peakwidth=c(5,50), snthresh=50, mzdiff=0.01, prefilter=c(3,1500000))
found_neg <- findPeaks.centWave(neg_data, ppm = 3, peakwidth=c(5,50), snthresh=50, mzdiff=0.01, prefilter=c(3,1500000)) 


# cuts out data that isn't needed 
trim_pos <- cbind(found_pos@.Data[,1], found_pos@.Data[,4], found_pos@.Data[,7])
colnames(trim_pos) <- c("mz", "rt", "intensity")

trim_neg <- cbind(found_neg@.Data[,1], found_neg@.Data[,4], found_neg@.Data[,7])
colnames(trim_neg) <- c("mz", "rt", "intensity")

# outputs CSVs
write.csv(trim_pos, file = paste("pos-", substr(input_filename, 1, nchar(input_filename)-6), ".csv", sep = ""), row.names = F)
write.csv(trim_neg, file = paste("neg-", substr(input_filename, 1, nchar(input_filename)-6), ".csv", sep = ""), row.names = F)



