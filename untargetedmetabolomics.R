## for xcms see
## http://bioconductor.org/packages/devel/bioc/html/xcms.html
library(xcms)

setwd("C:/Users/Lab/Desktop/Coding_Bits/untargetedMetabolomics")

# reads in files from a .txt file with this name. Each filename is on 
# a new line. (can do this by having a folder with all files in it,
# then navigate into that folder and enter the followign command:
# >>> dir /b > filenames.txt)
files <- scan("filenames.txt", what = "", sep="\n")

trim <- function(filledset){
  trimmedmatrix  <- cbind(filledset@peaks[,1],filledset@peaks[,4],filledset@peaks[,7])
  colnames(trimmedmatrix)  <- c('mz', 'rt', 'into')
  trimmedmatrix
}


filesN <- c(
  "ACM_Feb6_244-neg.mzXML",
  "ACM_Feb6_268-neg.mzXML",
  "ACM_Feb6_277-neg.mzXML",
  "ACM_Feb6_B2_255-neg.mzXML",
  "ACM_Feb6_B2_274-neg.mzXML",
  "ACM_Feb6_B3_270-neg.mzXML"
)

filesP <- c(
  "ACM_Feb6_244-pos.mzXML",
  "ACM_Feb6_268-pos.mzXML",
  "ACM_Feb6_277-pos.mzXML",
  "ACM_Feb6_B2_255-pos.mzXML",
  "ACM_Feb6_B2_274-pos.mzXML",
  "ACM_Feb6_B3_270-pos.mzXML"
)

# Reads in files and creates an XCMS Set object  # SN up reduces number of peaks. Prefilter ^ >> 
xsetN <- xcmsSet(filesN, method = "centWave", ppm = 3, peakwidth=c(5,50), snthresh=50, mzdiff=0.01, prefilter=c(3,1500000))
xsetP <- xcmsSet(filesP, method = "centWave", ppm = 3, peakwidth=c(5,50), snthresh=50, mzdiff=0.01, prefilter=c(3,1500000))

groupedN <- group(xsetN)
groupedP <- group(xsetP)

filledN <- fillPeaks(groupedN)
filledP <- fillPeaks(groupedP)
filledN
filledP

trimmedN <- trim(filledN)
trimmedP <- trim(filledP)

### Output name is left to be adjusted by user
write.csv(trimmedN, file = "acm-untargeted-neg.csv", row.names = FALSE) # change text inside quotes to what the negative file should be named
write.csv(trimmedP, file = "acm-untargeted-pos.csv", row.names = FALSE) # change text inside quotes to what the positive file should be named
 
filledN
filledP
# intensity retention time and m/z for positive and negative separately
# Run all 4 files (Tri files and ACM files from Drive) <- also want VanKs (scatter and heat)
# and duplicate and compounds list (same starter compound list too)


### NOTE AND RANDOM SNIPPETS

# Command prompt: 
# msconvert *.RAW --mzXML --filter "peakPicking true 1" --filter "polarity negative" -o C:/Users/Lab/Desktop/examples/negxmlfiles -v



setwd("C:/Users/Lab/Desktop/examples")

msconvert <- c("msconvert.exe")

FILES <- c(
  "Tri3_25.raw",
  "Tri4_25.raw"
)

# FILES <- list.files(recursive=TRUE, full.names=TRUE, pattern="\\.raw")
show(FILES)
for (i in 1:length(FILES))
{system (paste(msconvert," --mzXML --filter \"peakPicking true 1\" --filter \"polarity positive\" -o C:/rprocessing/converted/posmzxmlfiles -v",FILES[i]))}
for (i in 1:length(FILES))
{system (paste(msconvert," --mzXML --filter \"peakPicking true 1\" --filter \"polarity negative\" -o C:/rprocessing/converted/negmzxmlfiles -v",FILES[i]))}







