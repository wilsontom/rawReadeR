#' Get B Value
#'
#' Get the FT-MS conversion parameter \code{B} for each scan in a given range
#'
#' @param filename a \code{.raw} file
#' @param scans a numeric vector of scan numbers to extract
#' @return a numeric vector of the B value for each scan
#' 
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @usage
#' \dontrun{
#'	getBValues(QC.raw, scans = c(2:24)	
#'	}
#'
getBValues <- function(filename, scans = c())
	{
	options(digits = 15)
	BVal <- NULL
	for(i in 1:length(scans)){
		BVal[i] <- shell(paste(system.file("bin/GetBValue.exe", package = "rawReadR"), filename, scans[i], sep = " "), intern = TRUE)
	}
	
	BVals <- gsub("Conversion Parameter B:", "", BVal)
	
	return(as.numeric(BVals))
	}
 