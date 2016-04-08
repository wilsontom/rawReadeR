#' Get C Value
#'
#' Get the FT-MS conversion parameter \code{C} for each scan in a given range
#'
#' @param filename a \code{.raw} file
#' @param scans a numeric vector of scan numbers to extract
#' @return a numeric vector of the C value for each scan
#' 
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @examples
#' \dontrun{
#'	getCValues(QC.raw, scans = c(2:24)	
#'	}
#'
getCValues <- function(filename, scans = c())
	{
	options(digits = 15)
	
	CVal[i] <- sapply(scans, function(x)(shell(paste(system.file("bin/GetCValue.exe", package = "rawReadeR"), filename, x, sep = " "), intern = TRUE)))
	CVals <- gsub("Conversion Parameter C:", "", CVal)
	
	return(as.numeric(CVals))
	}
 