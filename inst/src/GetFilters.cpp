#include <iostream>
#include <io.h>
#include <comutil.h>
#include <string>
#import "C:\Thermo\MSFileReader.XRawfile2.dll"

using namespace std;

//Set argc,argv for command line input
int main(int argc, char *argv[])
{
	//Declare all variables
	VARIANT varFilters;
	VariantInit(& varFilters);
	long nArraySize = 0;
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

	//Get Filters
	nRet = m_Raw->GetFilters(&varFilters, &nArraySize);
	if (nRet != 0) {
		cout << "Error: unable to retrive MS filters" << endl;
	}

	//Use SAFEARRY to access contents
	SAFEARRAY FAR* psa = varFilters.parray;
	varFilters.parray = NULL;
	BSTR* pbstrFilters = NULL;
	SafeArrayAccessData(psa, (void**)(&pbstrFilters));

	//Print out contents of array
	for (long i = 0; i<nArraySize; i++)
	{
		wcout << pbstrFilters[i] << endl;
	}
	// Delete SafeArray's
	SafeArrayUnaccessData( psa);
	SafeArrayDestroy( psa);

	// end
}
