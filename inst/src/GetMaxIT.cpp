#include <iostream>
#include <io.h>
#include <comutil.h>
#include <string>
#import "C:\Thermo\MSFileReader.XRawfile2.dll"

using namespace std;

// add last scan check 

//Set argc,argv for command line input
int main(int argc, char *argv[])
{
	//Convert charatcer input (scan number) to int
	std::string numscan;
	numscan = argv[2];
	long nScanNumber = atoi(numscan.c_str());
        
   	//Declare all variables
	long lastScanNumber;
    long nRet;
    VARIANT varLabels;
	VariantInit(&varLabels);
    long nArraySize = 0;
	VARIANT varValues;
	VariantInit(&varValues);
		
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
    
    m_Raw->GetLastSpectrumNumber(&lastScanNumber);
	if (nScanNumber > lastScanNumber) {
		cout << "Scan number is greater than the last scan...terminating" << endl;
		exit(EXIT_FAILURE);
	}

	nRet = m_Raw->GetTrailerExtraForScanNum(nScanNumber,&varLabels, &varValues, &nArraySize);
	if (nRet != 0) {
		cout << "Error: unable to retrieve Trailer Data for given Scan Number" << endl;
	}
    
    SAFEARRAY FAR* psaLabels = varLabels.parray;
    varLabels.parray = NULL;
    SAFEARRAY FAR* psaValues = varValues.parray;
    varValues.parray = NULL;
    BSTR* pbstrLabels = NULL;
    BSTR* pbstrValues = NULL;
    
    SafeArrayAccessData( psaLabels, (void**)(&pbstrLabels));
    SafeArrayAccessData( psaValues, (void**)(&pbstrValues));
    

	for (long i = 0; i<nArraySize; i++)
	{
		if (wcsstr(pbstrLabels[i], L"Max. Ion Time (ms)") != 0) {
			wcout << pbstrLabels[i] << ":" << pbstrValues[i] << endl;
		}
	}

	
	// Delete SafeArray's
	SafeArrayUnaccessData( psaLabels);
	SafeArrayDestroy( psaLabels);
	SafeArrayUnaccessData( psaValues);
	SafeArrayDestroy( psaValues);
	
	// end        
}