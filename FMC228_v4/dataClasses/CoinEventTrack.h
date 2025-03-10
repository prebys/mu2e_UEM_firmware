/*
 * CoinEventTrack.h
 * This is Coincidence Acc. Trig. Event with to Track Event Class
 *
 *  Created on: Mar 29, 2021
 *      Author: Nguyen Minh Truong
 *      Follow the raw event of vratik
 */

#ifndef DATACLASSES_COINEVENTTRACK_H_
#define DATACLASSES_COINEVENTTRACK_H_

#include <iostream>

//#include "Rtypes.h"
#include "TError.h"
#include "TGraph.h"
#include "TArrayD.h"
#include "TProfile2D.h"

#include <vector> 

//#define NCELLS 1024

using std::cout;
using std::endl;

class CoinEventTrack {

private:
//	Double_t fAmp[NCELLS]; //array for raw amplitudes
//	Double_t fTime[NCELLS]; //array for raw times

	TArrayD fAmp;	//array for raw amplitudes
	TArrayD fTime;	//array for raw times
	TArrayD fPeakHigh;	//array for raw times
	TArrayD fPeakHighTime;	//array for raw times
	TArrayD fPeakSum;	//array for raw times
	TArrayD fPeakSumTime1;	//array for raw times
	TArrayD fPeakSumTime2;	//array for raw times

	std::vector<Double_t> fvAmp;
	std::vector<Double_t> fvTime;
	std::vector<Double_t> fvPeakHigh;
	std::vector<Double_t> fvPeakHighTime;
	std::vector<Double_t> fvPeakSum;
	std::vector<Double_t> fvPeakSumTime1;
	std::vector<Double_t> fvPeakSumTime2;
	

	const Int_t fNPoints;	//!

	TGraph *fGraphSignal;

//	TGraph *gAmp;

//public:
//	TArrayD fAmpA;

public:
	CoinEventTrack();
	CoinEventTrack(const Int_t npoints);
	virtual ~CoinEventTrack();
	ClassDef(CoinEventTrack,1);

	void Reset();
	//Resets arrays to zeros

	const Double_t* GetAmp() const { return fAmp.GetArray(); }
	
	const Double_t* GetTime() const { return fTime.GetArray(); }

	const Double_t* GetPeakHigh() const { return fPeakHigh.GetArray(); }
	const Double_t* GetPeakHighTime() const { return fPeakHighTime.GetArray(); }

	const Double_t* GetVAmp() const { return fvAmp.data(); }
	const Double_t* GetVTime() const { return fvTime.data(); }

	const Double_t* GetVPeakHigh() const { return fvPeakHigh.data(); }
	const Double_t* GetVPeakHighTime() const { return fvPeakHighTime.data(); }

	const Double_t* GetVPeakSum() const { return fvPeakSum.data(); }
	const Double_t* GetVPeakSumTime1() const { return fvPeakSumTime1.data(); }
	const Double_t* GetVPeakSumTime2() const { return fvPeakSumTime2.data(); }

	const Double_t* GetPeakSum() const { return fPeakSum.GetArray(); }
	const Double_t* GetPeakSumTime1() const { return fPeakSumTime1.GetArray(); }
	const Double_t* GetPeakSumTime2() const { return fPeakSumTime2.GetArray(); }


	void SetAmp(Double_t a, Int_t i);
	//Takes amplitude (raw data, voltage from binary file) 
	//and places it in the array fAmp

	void SetTime(Double_t t, Int_t i);

	void SetfvAmp(Double_t t);
	void SetfvTime(Double_t t);

	void SetfvPeakHigh(Double_t t);
	void SetfvPeakHighTime(Double_t t);

	void SetfvPeakSum(Double_t t);
	void SetfvPeakSumTime1(Double_t t);
	void SetfvPeakSumTime2(Double_t t);

	//Takes time (raw data, times from binary file) 
	//and places it in the array fTime

	void SetPeakHigh(Double_t t, Int_t i);
	void SetPeakHighTime(Double_t t, Int_t i);
	void SetPeakSum(signed long int t, Int_t i);
	void SetPeakSumTime1(Double_t t, Int_t i);
	void SetPeakSumTime2(Double_t t, Int_t i);
	void PrintAmp(Int_t i);
	//Prints i amplitudes (to make sense i shold be NCELLS)

	void PrintTime(Int_t i);

	void ProcessEvent();

	Double_t GetTime(Int_t i);

	Double_t GetAmp(Int_t i);

	Double_t GetPeakHigh(Int_t i);
	Double_t GetPeakHighTime(Int_t i);

	Double_t GetVAmp(Int_t i);
	Double_t GetVTime(Int_t i);

	Double_t GetVPeakHigh(Int_t i);
	Double_t GetVPeakHighTime(Int_t i);

	Double_t GetVPeakSum(Int_t i);
	Double_t GetVPeakSumTime1(Int_t i);
	Double_t GetVPeakSumTime2(Int_t i);

	Double_t GetVAmpSize();

	Double_t GetVPeakHighSize();
	Double_t GetVPeakSumSize();

	Double_t GetPeakSum(Int_t i);

	Double_t GetPeakSumTime1(Int_t i);
	Double_t GetPeakSumTime2(Int_t i);

	TGraph* GetGraphSignal(){
		return fGraphSignal;
	}
//	void InvertAmp(Double_t a, Int_t i);
	//Inverts the amplitudes i.e. makes from negative singals 
	//posititve signals and vise versa.

//	void SetGraphs();
//	TGraph* GetGraph() {
//		return gAmp;
//	}
//
	//void GetSample(int i){
	//    //if(i>=0 && i<(int)fSamples.size())
	//     return fSamples->at(i);
	//    //return 9999999;
	//}
	//void AddSamples(std::vector<double>Samples){
	//	fSamples = Samples;
	//}

	void SetGraphs();
private:
	void Init();
	//std::vector<Double_t> fvPeakHighTime;
	//std::vector<Double_t> fvPeakHigh;
	//void SetGraphs();
};

#endif /* DATACLASSES_RAWEVENT_H_ */
