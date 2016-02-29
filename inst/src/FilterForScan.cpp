#include <iostream>
#include <io.h>
#include <comutil.h>
#include <string>
#import "C:\Thermo\MSFileReader.XRawfile2.dll"

using namespace std;

//Set argc,argv for command line input
int main(int argc, char *argv[])
{
	//Convert character input (scan number) to int
	std::string numscan;
	numscan = argv[2];
	int nScanNumber = atoi(numscan.c_str());

	//Declare all variables
	long lastScanNumber = 0;
	BSTR bstrFilter = NULL;
	long nRet;

	//Decalre variables for .raw input
	TCHAR pth[MAX_PATH];
	MSFileReaderLib::IXRawfile4Ptr m_Raw;

	//Initillise the COM interface
	HRESULT hr = CoInitialize(NULL);

	//Access the MSFileReader .dll
	hr = m_Raw.CreateInstance("MSFileReader.XRawfile.1");
	if (FAILED(hr)) {
		cout << "Can't access the MSFileReader .dll" << endl;
	}

	//Read in a .raw file from argv[1] and open
	MultiByteToWideChar(CP_ACP, 0, argv[1], -1, (LPWSTR)pth, MAX_PATH);
	m_Raw->Open((LPWSTR)pth);

	//Set the current controller
	m_Raw->SetCurrentController(0, 1);

	//Check that given scan number (argv[2]) is within range of available scans
	m_Raw->GetLastSpectrumNumber(&lastScanNumber);
	if (nScanNumber > lastScanNumber) {
		cout << "Scan number is greater than the last scan...terminating" << endl;
		exit(EXIT_FAILURE);
	}

	//Get Filters

	nRet = m_Raw->GetFilterForScanNum(nScanNumber, &bstrFilter);
	if (nRet != 0) {
		cout << "Error: unable to retrive MS filters" << endl;
	}
	wcout << bstrFilter << endl;

	// end
}
