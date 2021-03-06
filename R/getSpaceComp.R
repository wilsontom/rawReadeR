#' Get Space Charge Compensation
#'
#' Get the space charge mass compensation (ppm) for each scan in a given range
#'
#' @param filename a \code{.raw} file
#' @param scans a numeric vector of scan numbers to extract
#' @return a numeric vector of the space charge compensation for each scan
#' 
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @examples
#' \dontrun{
#'	getSpaceComp(QC.raw, scans = c(2:24)	
#'	}
#'
getSpaceComp <- function(filename, scans = c())
	{
	options(digits = 15)

	SpaceComp <- sapply(scans, function(x)(shell(paste(system.file("bin/GetSpaceChargeComp.exe", package = "rawReadeR"), filename, x, sep = " "), intern = TRUE)))
	
	if(length(grep("::", SpaceComp)) == length(SpaceComp)){
		SpaceComp <- gsub("Space Charge Comp. \\(ppm\\)::", "", SpaceComp)
	}else{
		SpaceComp <- gsub("Space Charge Comp. \\(ppm\\):", "", SpaceComp)
	}
	
	return(as.numeric(SpaceComp))
	}
 