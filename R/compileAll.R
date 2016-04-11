#' Compile .cpp files to executables (.exe)
#' 
#' Wrapper function which compiles all \code{.cpp} files into executables (\code{.exe}). 
#' The Microsoft Visual Studio \code{vcvars323.bat} file is used to set paths and environment
#' variables, so that this function can be simply executed to the Windows \code{cmd} line from
#' an R session, as opposed to manually compiling all \code{.cpp} files through the Visual Studio
#' C++ Developers Command Prompt. See \link{https://github.com/wilsontom/rawReadeR/blob/master/README.md} for 
#' futher details in installation. 
#'
#' @param filepath the filepath of the \code{rawReadeR} source directory. 
#' @return NULL
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#'
#' @examples 
#'	\dontrun{
#'  options(VCPATH = "<path_to_visual_studio_vcvars32.bat>")
#'  compileAll("C:/User/Downloads/rawReadeR")
#'	}
#'
compileAll <- function(filepath)
	{
	
	if(is.null(getOption("VCPATH"))){
		stop("...The vcvars32.bat filepath has not been set in options. This MUST be done before compiliation", call. = FALSE)
	}
	
	## use working directories to make things a bit easier
	
	# start off in the source directory
	setwd(filepath)
	topDir <- getwd()
	
	# make bin directory for .exe
	setwd("inst")
	makeBinDir <- "mkdir bin"
	shell(makeBinDir, intern = FALSE)
	
	## compile all src/.cpp into the bin directory
	setwd("bin")
	srcDir <- gsub("bin", "src", getwd())
	cppFiles <- list.files(srcDir, pattern = "cpp", full = TRUE)
	
	# build the compilation command & run
	setVars <- setVars <- paste('""',getOption("VSPATH"),'""', sep = "")
	for(i in 1:length(cppFiles)){
		compileCmd <- paste("cl /EHsc", cppFiles[i], sep = " ")
		fullCmd <- paste(setVars, "&", compileCmd, sep = " ")
		shell(fullCmd, intern = FALSE)
	}
	
	# clean up all the non .exe files
	delFiles <- list.files(pattern = c(".obj|.tlh|.tli"))
	for(i in 1:length(delFiles)){	
		delCmd <- paste("del", delFiles[i], sep = " ")
		shell(delCmd, intern = TRUE)
	}
	
	# write binaryFile (this will prevent R CMD CHECK warnings)	
	setwd("rawReadeR")
	binFiles <- list.files("inst/bin", pattern = ".exe", full = TRUE)
	write(binFiles, file = "BinaryFiles")
	
	## done
	message("...Compilation complete, rawReader is ready for installation", "\n")
	
	return(invisible(NULL))
	}
	