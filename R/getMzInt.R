#' Get Mass and Intensity
#'
#' Get the profile data (m/z and intensity) across a given scan range
#'
#' @param filename a \code{.raw} file
#' @param scans a numeric vector of scan numbers to extract
#' @return a list of matrices for m/z and intensity. 
#' 
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @examples
#' \dontrun{
#'	getMzInt(QC.raw, scans = c(2:24)	
#'	}
#'
getMzInt <- function(filename, scans = c())
	{
	options(digits = 15)
	MzInt <- NULL
	for(i in 1:length(scans)){
		MzInt[[i]] <- shell(paste(system.file("bin/GetLabelData.exe", package = "rawReadeR"), filename, scans[i], sep = " "), intern = TRUE)
	}
	
	MzIntSplit <- sapply(MzInt, function(x)(strsplit(x, ":")))
	
	MzIntMat <- NULL
	for(i in 1:length(MzIntSplit)){
		MzIntMat[[i]] <- sapply(MzIntSplit[[i]], function(x)(matrix(as.numeric(x),nrow = 2)))
	}
	MzIntMat <- sapply(MzIntMat, t)
	
	for(i in 1:length(MzIntMat)){
		colnames(MzIntMat[[i]]) <- c("mz", "int")
	}
	return(MzIntMat)
	}
 