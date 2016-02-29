#include <iostream>
#include <io.h>
#import "C:\Thermo\MSFileReader.XRawfile2.dll"

using namespace std;

	//Set argc,argv for command line input
int main(int argc, char *argv[])
{
	//Declare all variables
	long firstScanNumber = 0;
	long lastScanNumber = 0;
	int totalNumScans;

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


	//Get the first scan number
	m_Raw->GetFirstSpectrumNumber(&firstScanNumber);

	//Get the last scan number
	m_Raw->GetLastSpectrumNumber(&lastScanNumber);

	//Calculate total scans
	totalNumScans = (lastScanNumber - firstScanNumber) + 1;

	//Return total scans
	cout << totalNumScans << endl;

	// end
}
