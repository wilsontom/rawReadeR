.onLoad <- function(libname = find.package("rawReadeR"), pkgname = "rawReadeR")
	{
	if(.Platform$OS.type != "windows"){
		stop("This package can only be used on a Windows OS", call. = FALSE)
	}
	}