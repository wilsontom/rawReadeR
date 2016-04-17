#' Package Testing
#'
#' Run some basic tests to ensure there have been no problems during compilation
#'
#' @param scans a numeric vector of scan numbers to extract
#' @return NULL
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#'
#' @examples
#'	\dontrun{
#'		testPackage(scans = c(1:5))
#' }

testPackage <- function(scans = c(1:5))
	{
	rawFile <- system.file("extdata", "testfile.raw", package = "rawReadeR")

	if(!is.numeric(getBValues(rawFile, scans))){
		message("..Error found in 'getBValues'")
	}
	if(length(getBValues(rawFile, scans)) != length(scans)){
		message("..Error found in 'getBValues'")
	}
	if(!is.numeric(getCValues(rawFile, scans))){
		message("..Error found in 'getCValues'")
	}
	if(length(getCValues(rawFile, scans)) != length(scans)){
		message("..Error found in 'getCValues'")
	}
	if(!is.numeric(getITtime(rawFile, scans))){
		message("..Error found in 'getITtime'")
	}
	if(length(getITtime(rawFile, scans)) != length(scans)){
		message("..Error found in 'getITtime'")
	}
	if(!is.numeric(getResComp(rawFile, scans))){
		message("..Error found in 'getResComp'")
	}
	if(length(getResComp(rawFile, scans)) != length(scans)){
		message("..Error found in 'getResComp'")
	}
	if(!is.numeric(getSpaceComp(rawFile, scans))){
		message("..Error found in 'getSpaceComp'")
	}
	if(length(getSpaceComp(rawFile, scans)) != length(scans)){
		message("..Error found in 'getSpaceComp'")
	}
	if(!is.numeric(getRFComp(rawFile, scans))){
		message("..Error found in 'getRFComp'")
	}
	if(length(getRFComp(rawFile, scans)) != length(scans)){
		message("..Error found in 'getRFComp'")
	}

	profileList <- getMzInt(rawFile, scans)
	if(!is.list(profileList)){
		message("..Error found in 'getMzInt'")
	}
	if(!is.list(profileList)){
		message("..Error found in 'getMzInt'")
	}
	if(all(sapply(profileList,ncol) != 2)){
		message("..Error found in 'getMzInt'")
	}

	profileList2 <- getMzIntNoise(rawFile, scans)
	if(!is.list(profileList2)){
		message("..Error found in 'getMzIntNoise'")
	}
	if(length(profileList2) != length(scans)){
	message("..Error found in 'getMzIntNoise'")
	}
	if(all(sapply(profileList2,ncol) != 3)){
		message("..Error found in 'getMzIntNoise'")
	}
	
	message("...all tests finished", "\n")
	
	return(invisible(NULL))
	}

