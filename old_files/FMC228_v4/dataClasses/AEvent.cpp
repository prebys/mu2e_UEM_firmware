/*
 * AEvent.cpp
 *
 *  Created on: Dec 28, 2016
 *      Author: daria
 */

#include "AEvent.h"
AEvent::AEvent() : fNPoints(1024) {	//fNPoints is number of points in one event, 1024 or 1000

	Init();
	Reset();

}

AEvent::AEvent(const Int_t npoints) : fNPoints(npoints) {

	Init();
	Reset();
}

AEvent::~AEvent() {
	// TODO Auto-generated destructor stub
	delete fGraphSignal;
	delete fGraphCFD;
	delete fInputEvent;
}


void AEvent::ProcessEvent(Bool_t bSmooth) {

	if (fInputEvent == NULL) {
		Warning("AEvent::ProcessEvent", "Input event wasn't set. Function won't be processed.");
		return;
	}

	const Double_t *amp = fInputEvent->GetAmp();
	const Double_t *time = fInputEvent->GetTime();

	for(Int_t j = 0; j < fNPoints; j++) {
		fAmpPos[j] = amp[j]*(-1.);
		fTime[j] = time[j];
	}

	fZeroLevel = FindZeroLevel();
	for(Int_t j = 0; j < fNPoints; j++) {
		fAmpPos[j] = fAmpPos[j] - fZeroLevel;
	}

	SetMaxAmplitudes();

	if (bSmooth == kTRUE) {
		SmoothGraphs();
	}
	else {
		SetGraphs();
	}

	FindFrontProperties();
	SetLED();
//	SetGraphs();

	SetCFD();
	SetChargeCFD();
	SetChargeLED();
	SetChargeTF();
	SetToT();
	SetThreshold();
//	SmoothGraphs();

	return;

}

void AEvent::Reset() {

	for (Int_t i = 0; i < fNPoints; i++) {
		fAmpPos[i] = 0;
		fTime[i] = 0;
		fAmpCFD[i] = 0;
	}
	fTimeLED = -100.;
	fEdgeSlope=0.;
	fEdgeXi=0.;
	fEdgeSlope=-100.;
	fTime10=0.;
	fTime90=0.;
	fTimeMid=0.;
	fToT=-100.;
	fAmpMid=0.;
	fAmpMax = 0.;
	fTimeAmpMax = 0.;
	fTimeCFD = -100.;
	fZeroLevel = 0.;
	fChargeCFD = -10.;
	fChargeLED = -10.;
	fTimeFront = -100.;
	fTimeThreshBack = -100.;
	fTimeThresh = -100.;
}

void AEvent::SetInputEvent(RawEvent** event) {

	if (event == 0) {
		Warning("AEvent::SetInputEvent", "Input event was set as 0.");
	}
	fInputEvent = *event;

}

void AEvent::Init() {

	fAmpPos.Set(fNPoints);
	fTime.Set(fNPoints);
	fAmpCFD.Set(fNPoints);

	fGraphSignal = new TGraph();
	fGraphCFD = new TGraph();
//	fGraphSmooth = new TGraph();
	fInputEvent = 0;

	fCFratio = 0.;
	fCFtimeDelay = 0.;

	fNoiseRangeMin = 0.;
	fNoiseRangeMax = 1.;

}

void AEvent::SetGraphs() {

	fGraphSignal->Set(fNPoints);

	for (Int_t i=0; i<fNPoints; i++) {
		fGraphSignal->SetPoint(i, fTime[i], fAmpPos[i]);
	}

	return;
}

void AEvent::SmoothGraphs() {

	//smoothing graph
	fGraphSignal->Set(fNPoints - fWinSize/2);

	Int_t winMidSize = fWinSize / 2;	
	Double_t tmin, tmax, meanTime, meanAmp, sumAmp;	

	for(Int_t i = winMidSize; i < fNPoints - winMidSize; ++i) {
   		sumAmp = 0;
		tmin = 0;
		tmax = 0;
		meanTime = 0;
		meanAmp = 0;
    		for(Int_t j = i - winMidSize; j <= (i + winMidSize); ++j) {
			if (j == i - winMidSize) { tmin = fTime[j]; }
			if (j == i + winMidSize) { tmax = fTime[j]; }
      			sumAmp += fAmpPos[j];
    		}
		meanTime = (tmax - tmin)*0.5 + tmin;
		//cout<<"mean time "<<meant<<endl;

    		meanAmp = sumAmp / fWinSize;
		//cout<<"mean amp "<<fAmpPos[i]<<endl;

    	fGraphSignal->SetPoint(i, meanTime, meanAmp);
		
	}	

//	fGraphSignal->Clone

	return;
}

void AEvent::SetCFD() {

	Double_t time = 0;
	Double_t mytime = fCFtimeDelay;
	fGraphCFD->Set(fNPoints);

	//working variables
	Double_t maxCFD = 0., minCFD = 0.;
	Double_t TmaxCFD = 0., TminCFD = 0.;	
	Double_t ampCFD;
	const Double_t timeStep = 0.1;
	Int_t i = 0; //for graph 
 
	//while goes by the graph with the step of timeStep
	while( mytime < (fTimeLast - fCFtimeDelay) ) {

		ampCFD = fGraphSignal->Eval(mytime)*fCFratio*(-1) + fGraphSignal->Eval(mytime - fCFtimeDelay);
		fGraphCFD->SetPoint(i, mytime, ampCFD);

		//point for max CFD amplitude
		if( ampCFD > maxCFD) {
			maxCFD = ampCFD;
			TmaxCFD = mytime;
		}

		//point for min CFD amplitude
		if( ampCFD < minCFD) {
			minCFD = ampCFD;
			TminCFD = mytime;
		}

		i++;
		mytime = mytime + timeStep;
	}

	//looking for the first point with the closest values to 0 and writing to fTimeCFD
	time = TminCFD;
	while( (fGraphCFD->Eval(time) <= 0) && (time <= TmaxCFD) /*&& (time >= TminCFD)*/ ) {
		fTimeCFD = time;
		time = time + timeStep;
	}

}

void AEvent::FindFrontProperties() {

	//in percents
	const Double_t minHeight = 0.1;
	const Double_t maxHeight = 0.9;

	const Double_t timeStep = 0.05;	//in ns
	Double_t time = 0;			//in ns
	Double_t mytime = fTimeAmpMax;

	if (!fGraphSignal) {
		Warning("AEvent::FindFrontProperties", "Graph was not set");
		return;
	}

	//TODO search of minimum should be done from the lower edge on the time axis

	while (fGraphSignal->Eval(time) <= maxHeight*fAmpMax && time<200.) {
		fTime90 = time;
		time = time + timeStep;
	};

	time = fTime90;
	while( fGraphSignal->Eval(time) >= minHeight*fAmpMax && time>0) {
		fTime10 = time;
		time = time - timeStep;
	}

	TF1 *fit1 = new TF1("fit1","[1]*x+[0]");	//function for one parameter fitting in the range of pmin-pmax
	fit1->SetRange(fTime10,fTime90);

	fGraphSignal->Fit(fit1,"RQN","goff");

	fEdgeSlope = fit1->GetParameter(1);
	fEdgeXi = fit1->GetChisquare();

	fTimeMid = (fTime90 -fTime10)*0.5 + fTime10; 	//time point between fTime90 and fTime10
	fAmpMid = fGraphSignal->Eval(fTimeMid);

	//adding point where fit function crosses zero
	Double_t a = 0, b = 0;
	TF1 *line = new TF1("line","[1]*x + [0]");
	a = fit1->GetParameter(1);
	b = fit1->GetParameter(0);
	line->SetParameter(0,b);
	line->SetParameter(1,a);	

	if( a!= 0. && b!= 0. ) {	//in case of fit data is empty
		while(line->Eval(mytime) >=0 && mytime <= fTimeLast && mytime>=0) {	
			//cout<< "mytime "<<mytime<<endl;
			fTimeFront = mytime;
			mytime = mytime - timeStep;
		}
	}

	delete fit1;
}

Double_t AEvent::FindZeroLevel() {

	SetGraphs();
	Double_t correction = 0;
	TF1 *fit1 = new TF1("fit1","[0]");	//function for one parameter fitting in the range of pmin-pmax
	fit1->SetRange(fNoiseRangeMin,fNoiseRangeMax);

	if (!fGraphSignal) {
		Warning("AEvent::FindZeroLevel", "Graph was not set");
		return 0;
	}

	fGraphSignal->Fit(fit1,"RQN","goff");
	correction = fit1->GetParameter(0);

	delete fit1;
	return correction;
}

void AEvent::SetChargeCFD(Int_t tmin, Int_t tmax) { // tmin = -3, tmax = 17
	
	Double_t integral = 0.;					//voltage
	Double_t time_sig = 0;					//approximate signal duration in seconds
	const Double_t res = 50.; 				//resistance 50 Om
	time_sig = (double)(-tmin + tmax);

	/*for(Int_t i = 0; i < fNPoints; i++) {
		if( fTime[i] > (fTimeCFD + tmin) && fTime[i] < (fTimeCFD + tmax) ) {
			integral = integral + fAmpPos[i];
		}
	}*/

	Int_t imin = 0, imax = 0;

	Int_t i = 0;
	while ( fTime[i] < (fTimeCFD + tmin) && (i < (fGraphSignal->GetN()-1)) ) { imin = i; i++; }
	while ( fTime[i] < (fTimeCFD + tmax) && (i < (fGraphSignal->GetN()-1)) ) { imax = i; i++; }

	integral = fGraphSignal->Integral(imin, imax);

	fChargeCFD = integral*time_sig/res;

	return;

}

void AEvent::SetChargeLED(Int_t tmin, Int_t tmax) { // tmin = -3, tmax = 17
	
	Double_t integral = 0.;					//voltage
	Double_t time_sig = 0;					//approximate signal duration in seconds
	const Double_t res = 50.; 				//resistance 50 Om
	time_sig = (double)(-tmin + tmax);

/*	for(Int_t i = 0; i < fNPoints; i++) {
		if( fTime[i] > (fTimeLED + tmin) && fTime[i] < (fTimeLED + tmax) ) {
			integral = integral + fAmpPos[i];
		}
	}*/

	Int_t imin = 0, imax = 0;

	Int_t i = 0;
	while ( fTime[i] < (fTimeLED + tmin) && (i < (fGraphSignal->GetN()-1)) ) { imin = i; i++; }
//	i = 0;
	while ( fTime[i] < (fTimeLED + tmax) && (i < (fGraphSignal->GetN()-1)) ) { imax = i; i++; }

	integral = fGraphSignal->Integral(imin, imax);

	fChargeLED = integral*time_sig/res;

	return;

}

void AEvent::SetChargeTF(Int_t tmin, Int_t tmax) { // tmin = -3, tmax = 17
	
	Double_t integral = 0.;					//voltage
	Double_t time_sig = 0;					//approximate signal duration in seconds
	const Double_t res = 50.; 				//resistance 50 Om
	time_sig = (double)(-tmin + tmax);

	Int_t imin = 0, imax = 0;

	Int_t i = 0;
	while ( fTime[i] < (fTimeFront + tmin) && (i < (fGraphSignal->GetN()-1)) ) { imin = i; i++; }
//	i = 0;
	while ( fTime[i] < (fTimeFront + tmax) && (i < (fGraphSignal->GetN()-1)) ) { imax = i; i++; }

	integral = fGraphSignal->Integral(imin, imax);

	fChargeTF = integral*time_sig/res;

	return;

}

Double_t AEvent::GetfCFD() {
		return fTimeCFD;
}

Double_t AEvent::GetfLED() {
		return fTimeLED;
}

Double_t AEvent::GetfThresh() {
	return fTimeThresh;
}

Double_t AEvent::GetOnefTime(Int_t i) {
		return fTime[i];
}

Double_t AEvent::GetOnefAmpPos(Int_t i) {
		return fAmpPos[i];
}

Double_t AEvent::GetT_10() {
		return fTime10;
}

Double_t AEvent::GetT_90() {
		return fTime90;
}

Double_t AEvent::GetEdgeSlope() {
		return fEdgeSlope;
}

Double_t AEvent::GetEdgeXi() {
		return fEdgeXi;
}

Double_t AEvent::GetfChargeCFD() {
		return fChargeCFD;
}

Double_t AEvent::GetfChargeTF() {
		return fChargeTF;
}

void AEvent::SetMaxAmplitudes() {
	Double_t maxAmp = 0.;
	Double_t maxAmpT = 0.;

	maxAmp = fAmpPos[0];
	for(Int_t j=0; j < fNPoints; j++) {
		if(fAmpPos[j] > maxAmp) {
			maxAmp = fAmpPos[j];
			maxAmpT = fTime[j];
		}
	}
	fAmpMax = maxAmp;
	fTimeAmpMax = maxAmpT;
	fTimeLast = fTime[fNPoints-1];
}

void AEvent::SetLED(Double_t threshold) {
	
	Double_t time = 0;
	const Double_t timeStep = 0.05;
	while( time < fTimeAmpMax && fGraphSignal->Eval(time) <= threshold ) {
		fTimeLED = time;
		time = time + timeStep;
	}
	//fTimeLED = time; найти номера точек которые лежат на 3 нс раньше и на 20 нс позже чем точка с временем timeled (искать точки в пределах условных)
	// сделать через функцию getpoint и цикл по точкам от 

}

void AEvent::SetThreshold(Double_t thresholdBack, Double_t threshRise) {
	
	Double_t time = fTimeAmpMax;
	const Double_t timeStep = 0.05;
	while( time < fTimeLast && fGraphSignal->Eval(time) >= thresholdBack ) {
		fTimeThreshBack = time;
		time = time + timeStep;
	}
	
	time  = fTimeAmpMax;
	
	while( time >0 && fGraphSignal->Eval(time) >= threshRise) {
		fTimeThresh = time;
		time = time - timeStep;
	}
	//fTimeLED = time; найти номера точек которые лежат на 3 нс раньше и на 20 нс позже чем точка с временем timeled (искать точки в пределах условных)
	// сделать через функцию getpoint и цикл по точкам от 

}

void AEvent::SetToT() {

	Double_t time = fTimeAmpMax;
	Double_t timeBack;
	const Double_t ns = 10.; //withing this interval signal should end for sure, in nanosec

	const Double_t timeStep = 0.05;

	//cout<<"fAmpMid "<<fAmpMid<<endl;
	while( fGraphSignal->Eval(time) >= fAmpMid &&  time < fTimeLast) {
		//cout<<"timeback "<<timeBack<<endl;
		//cout<<"fGraphSignal->Eval(time) "<<fGraphSignal->Eval(time)<<endl;
		//cout<<endl;
		//if(timeBack>150.) {return;}
		timeBack = time;
		time = time + timeStep;
	}
	//cout<<"timeback "<<timeBack<<endl;

	fToT = timeBack - fTimeMid;
	//cout<<"ftot "<<fToT<<endl;



}
