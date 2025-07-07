/*
 * AEvent.h
 *
 *  Created on: Dec 28, 2016
 *      Author: daria
 */

#ifndef DATACLASSES_AEVENT_H_
#define DATACLASSES_AEVENT_H_

#include <iostream>
#include <fstream>
#include <iomanip>
#include <sstream>

#include "TError.h"
#include "TString.h"
#include "TTree.h"
#include "TFile.h"
#include "TF1.h"
//#include "TMath.h"


#include "RawEvent.h"

//#define NCELLS 1024

using std::cout;
using std::endl;

class AEvent {

private:

	const Int_t fNPoints;	//!
	TArrayD fAmpPos;	//array for raw amplitudes
	TArrayD fTime;		//array for raw times

	Double_t fAmpMax;
	Double_t fTimeAmpMax;
	Double_t fZeroLevel;
	Double_t fEdgeXi;
	Double_t fEdgeSlope;	//slope coefficient for the rising edge of the signal
	Double_t fTime10;		//time of 10% of rising edge amplitude in ns
	Double_t fTime90;		//time of 10% of rising edge amplitude in ns
	Double_t fTimeMid;		//time point between fTime90 and fTime10
	Double_t fAmpMid;		//amplitude in fTimeMid point. Used in ToT on 50% of rising edge determination
	Double_t fToT;
	Double_t fTimeLast;  //!

	TArrayD fAmpCFD;	//array for CFD amplitudes (attenuated, inversed and delayed)
	Double_t fTimeCFD;			//zero-crossing time
//<<<<<<< HEAD
	Double_t fChargeCFD;
//=======
//	Double_t fChargeCFD;	//
//>>>>>>> 5eb9075c10d86d66bba9b5c694fbdb722d11105d
	Double_t fChargeLED;	//charge of the signal in Coulomb
	Double_t fChargeTF;	//

	Double_t fTimeThresh;  // time of thresh crossing rising edge
	Double_t fTimeThreshBack;  // time of threshBack crossing
	Double_t fTimeLED;	//time of LED threshold crossing
	Double_t fTimeFront;	//time of front fit crossing zero level

	TGraph *fGraphSignal;
	TGraph *fGraphCFD;
//	TGraph *fGraphSmooth;

	RawEvent *fInputEvent;		//!

	Double_t fCFratio;		//!
	Double_t fCFtimeDelay;		//!

	Double_t fNoiseRangeMin;	//!
	Double_t fNoiseRangeMax;	//!
	Int_t fWinSize;			//!

public:
	AEvent();
	AEvent(const Int_t npoints);
	virtual ~AEvent();
	ClassDef(AEvent,1);
	
	Double_t GetT_10();
	//returns time of 10% of rising edge amplitude in ns

	Double_t GetT_90();
	//returns time of 90% of rising edge amplitude in ns

	Double_t GetEdgeSlope();
	//returns slope coefficient for the rising edge of the signal

	Double_t GetEdgeXi();

	Double_t GetfChargeCFD();

	Double_t GetfChargeTF();

	Double_t GetfCFD();

	Double_t GetfLED();
	
	Double_t GetfThresh();
	
	Double_t GetOnefTime(Int_t i);

	Double_t GetOnefAmpPos(Int_t i);

	void ProcessEvent(Bool_t bSmooth = kFALSE);
	void SetInputEvent(RawEvent** event);

	void SetCFratio(Double_t ratio) { fCFratio = ratio; };	
	//CFD set attenuation coefficient

	void SetCFtimeDelay(Double_t timeDelay) { fCFtimeDelay = timeDelay; };	
	//CFD set time delay (in points)

	void SetNoiseRange(Double_t min, Double_t max) { fNoiseRangeMin = min; fNoiseRangeMax = max; };
	//Set noise range to be used in FindZeroLevel()

	void SetSmoothPoints(Int_t numofp) {fWinSize = numofp; };
	//set number of smoothing points

	void SetToT();
	//calculate time-over-threshold. the threshold value is fTimeMid - middle point of the rising edge
	//ToT is calculated within 15 ns range in order to consider all the weirdness of the signal form

	void Reset();
	 //Resets arrays to zeros

	TGraph* GetGraphCFD() {

		return fGraphCFD;
	}
	//draws CFD graphs

	TGraph* GetGraphSignal() {

		return fGraphSignal;
	}

	/*TGraph* GetGraphSmooth() {

		return fGraphSmooth;
	}*/
	//draws signal shape graphs

	void FindFrontProperties();

	Double_t FindZeroLevel();
	//for zero level correction. one parameter fit between pmin and pmax
	//returns fit parameter i.e. number on which amplitude should be corrected

	void SetChargeCFD(Int_t tmin = -3, Int_t tmax = 17);
	//calculates charge of the signal (i.e. its integral 
	//in range of (tmin,tmax) in ns)
	//CFD time is taken as a start point

	void SetChargeLED(Int_t tmin = -3, Int_t tmax = 17);

	void SetChargeTF(Int_t tmin = -3, Int_t tmax = 17);
	//calculates charge of the signal (i.e. its integral 
	//in range of (tmin,tmax) in ns) 
	//time of front fit crossing zero is taken as a start point

	//void SetLED(Double_t threshold = 0.001);

	void SetLED(Double_t threshold = 0.01);

	//leading edge discriminator
	void SetThreshold(Double_t thresholdBack = 0.035, Double_t threshRise = 0.01);
	
private:
	void Init();
	void SetMaxAmplitudes();
	void SetGraphs();
	void SmoothGraphs();
	void SetCFD(); 	//constant fraction discriminator method
};

#endif /* DATACLASSES_AEVENT_H_ */
