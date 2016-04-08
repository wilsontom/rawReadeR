#' Get RF Compensation
#'
#' Get the RF mass compensation (ppm) for each scan in a given range
#'
#' @param filename a \code{.raw} file
#' @param scans a numeric vector of scan numbers to extract
#' @return a numeric vector of the RF compensation for each scan
#' 
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @examples
#' \dontrun{
#'	getRFComp(QC.raw, scans = c(2:24)	
#'	}
#'
getRFComp <- function(filename, scans = c())
	{
	options(digits = 15)
		
	RFcomp <- sapply(scans, function(x)(shell(paste(system.file("bin/GetRFComp.exe", package = "rawReadeR"), filename, x, sep = " "), intern = TRUE)))
	
	RFcomp <- gsub("RF Comp. \\(ppm\\): ", "", RFcomp)
	
	return(as.numeric(RFcomp))
	}
 