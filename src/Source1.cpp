#include <comutil.h>
#include <stdio.h>
#include <io.h>
#include <fcntl.h>
#include <fstream>
#include <iostream>
#include <string.h>
#import "C:\Users\Tom\Desktop\XRawfile2_x64.dll"

using namespace std;

int main(int argc, char *argv[])
{
	int hlhs;
	int hrhs;
	
	struct myScan
	{
	int reads;
	double *mass;
	float *noise;
	double *intensity;
	float *resolution;
	float *baseline;
	int *charge;
	};
		
	//Declare for reading raw files
	//HRESULT lRet;
	TCHAR pth[MAX_PATH];
	MSFileReaderLib::IXRawfile4Ptr m_Raw;

	// Initialize COM interface
	HRESULT hr = CoInitialize(NULL);    

	//CoInitialize( NULL );
	hr = m_Raw.CreateInstance("MSFileReader.XRawfile.1");
	if (FAILED(hr)){

		cout << "Can't Access DLL" << endl;
	}
	MultiByteToWideChar(CP_ACP,0,argv[1],-1,(LPWSTR)pth,MAX_PATH);
    long lr = m_Raw->Open((LPWSTR)pth);
	
	m_Raw->SetCurrentController(0, 1);

	long firstScanNumber = 0, lastScanNumber = 0;

	hr = m_Raw->GetFirstSpectrumNumber(&firstScanNumber);
	
	m_Raw->GetLastSpectrumNumber(&lastScanNumber);
    
	long totalNumScans = (lastScanNumber - firstScanNumber) + 1;
	int scanNum;

	double RT;
    hr = m_Raw->RTFromScanNum(100,&RT);
	
	long nRet;
	long pnArraySize = 0;
	VARIANT pvarFilterArray ;
	VariantInit(&pvarFilterArray);

	double dHalfMassRes;
	nRet = m_Raw->GetMassResolution(&dHalfMassRes);
		
	cout << hr << endl;
	
	cout << "Hello, world, from Visual C++!" << endl;
	
	hr=m_Raw->Close();
}