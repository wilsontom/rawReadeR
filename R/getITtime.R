#' Get Ion Injection Time
#'
#' Get the ion injection time (IT) for each scan in a given range
#'
#' @param filename a \code{.raw} file
#' @param scans a numeric vector of scan numbers to extract
#' @return a numeric vector of the Ion Injection Time for each scan
#' 
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @usage
#' \dontrun{
#'	getITtime(QC.raw, scans = c(2:24)	
#'	}
#'
getITtime <- function(filename, scans = c())
	{
	options(digits = 15)
	IT <- NULL
	for(i in 1:length(scans)){
		IT[i] <- shell(paste(system.file("bin/GetIT.exe", package = "rawReadeR"), filename, scans[i], sep = " "), intern = TRUE)
	}
	
	IT <- gsub("Ion Injection Time \\(ms\\): ", "", IT)
	
	return(as.numeric(IT))
	}
 