#' Get Resolution Compensation
#'
#' Get the Resolution mass compensation (ppm) for each scan in a given range
#'
#' @param filename a \code{.raw} file
#' @param scans a numeric vector of scan numbers to extract
#' @return a numeric vector of the Resolution compensation for each scan
#' 
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @examples
#' \dontrun{
#'	getResComp(QC.raw, scans = c(2:24)	
#'	}
#'
getResComp <- function(filename, scans = c())
	{
	options(digits = 15)
	ResComp <- NULL
	for(i in 1:length(scans)){
		ResComp[i] <- shell(paste(system.file("bin/GetResComp.exe", package = "rawReadeR"), filename, scans[i], sep = " "), intern = TRUE)
	}
	
	ResComp <- gsub("Resolution Comp. \\(ppm\\): ", "", ResComp)
	
	return(as.numeric(ResComp))
	}
 