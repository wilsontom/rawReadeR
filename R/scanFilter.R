#' Get Filter
#'
#' Get the scan filter for each scan in a given range
#'
#' @param filename a \code{.raw} file
#' @param scans a numeric vector of scan numbers to extract
#' @return a character vector of the scan filter for each scan
#' 
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @examples
#' \dontrun{
#'	scanFilter(QC.raw, scans = c(2:24)	
#'	}
#'
scanFilter <- function(filename, scans = c())
	{
	scanFill <- sapply(scans, function(x)(shell(paste(system.file("bin/FilterForScan.exe", package = "rawReadeR"), filename, x, sep = " "), intern = TRUE)))
	return(scanFill)
	}
 