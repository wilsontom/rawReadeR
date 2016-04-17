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

    //string flag = argv[3];

	//Declare all variables
	VARIANT varLabels;
	VARIANT pvarLabels;
	VariantInit(&varLabels);
	VariantInit(&pvarLabels);
	
	VARIANT varFlags;
	VARIANT pvarFlags;

	VariantInit(&varFlags);
	VariantInit(&pvarFlags);
	
	SAFEARRAY *parray;
	_variant_t vSpecData;
	int dim;
	int inx;
	double *pdval;
	long nRet;
	long lastScanNumber;

	//float fBase;
	//float fNoise;
	//double dMass;

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

	nRet = m_Raw->GetLabelData(&pvarLabels, &pvarFlags, &nScanNumber);
	if (nRet != 0) {
		cout << "Error: unable to retrieve Label Data for given Scan Number" << endl;
	}

	vSpecData = pvarLabels;
	parray = vSpecData.parray;
	dim = parray->rgsabound[0].cElements;
	pdval = (double *)parray->pvData;    

        for (long i  = 0; i < dim; i++)
	    {
		cout << pdval[((i)* 6) + 0] << ":" << pdval[((i)* 6) + 1] << ":" << pdval[((i)* 6) + 4] << endl;
        }
   	
	// end
}