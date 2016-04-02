#' Get Mass, Intensity and Noise
#'
#' Get the profile data (m/z, intensity and noise) across a given scan range
#'
#' @param filename a \code{.raw} file
#' @param scans a numeric vector of scan numbers to extract
#' @return a list of matrices for m/z, intensity and noise
#' 
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @examples
#' \dontrun{
#'	getMzIntNoise(QC.raw, scans = c(2:24)	
#'	}
#'
getMzIntNoise <- function(filename, scans = c())
	{
	options(digits = 15)
	MzIntNoise <- NULL
	for(i in 1:length(scans)){
		MzIntNoise[[i]] <- shell(paste(system.file("bin/GetLabelDataNoise.exe", package = "rawReadeR"), filename, scans[i], sep = " "), intern = TRUE)
	}
	
	MzIntNoiseSplit <- sapply(MzIntNoise, function(x)(strsplit(x, ":")))
	
	MzIntNoiseMat <- NULL
	for(i in 1:length(MzIntNoiseSplit)){
		MzIntNoiseMat[[i]] <- sapply(MzIntNoiseSplit[[i]], function(x)(matrix(as.numeric(x),nrow = 3)))
	}
	MzIntNoiseMat <- sapply(MzIntNoiseMat, t)
	
	for(i in 1:length(MzIntNoiseMat)){
		colnames(MzIntNoiseMat[[i]]) <- c("mz", "int", "noise")
	}
	return(MzIntNoiseMat)
	}
 