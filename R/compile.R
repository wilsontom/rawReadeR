 

compile <- function(x)
	{
	
	# make bin directory for binaries
	
	makeBinDir <- "mkdir inst/bin"
	shell(makeBinDir, intern = FALSE)
	
	setwd("/inst/bin")
	
	srcDir <- gsub("bin", "src", getwd())
	cppFiles <- list.files(srcDir, pattern = "cpp", full = TRUE)
	
	# build the compilation command
	
	setVars <- "\"C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/bin/vcvars32.bat\""
	
	fullCmd <- paste(setVars, "&", compileCmd, sep = " ")
	
	
	compileCmd <- paste("cl /EHSc", cppFiles[1], sep = " ")
	
	# for loop to execute
	
	
	
	# clean up
	
	
	# write binaryFile
	
	
	
	}
	