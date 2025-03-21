//////////////////////////////////
// macro to plot peak height data given root file produced using read_binary
// pay attention to correct library path
// to file path and nevent as well
//
//

#include "TVectorD.h"
#include <TTree.h>
#include <TGraph.h>
#include <TFile.h>
#include <TSystem.h>
#include <TCanvas.h>
#include <TProfile2D.h>
#include <TStyle.h>
#include "../dataClasses/RawEvent.h"
#include "TSystem.h"
using namespace std;
#include <algorithm>
#include <iterator>
#include <iostream>
R__LOAD_LIBRARY($/home/kujiwado/WorkDir/FileTransfer/mu2euem/FMC228_v3/libData.so)

void ShowProf_rawevent2()
{

  gStyle ->SetCanvasDefH(900);
  gStyle ->SetCanvasDefW(1500);

  gSystem->Load("/home/kujiwado/WorkDir/FileTransfer/mu2euem/FMC228_v3/libData.so");

  TFile *fr = new TFile("/home/kujiwado/WorkDir/FileTransfer/mu2euem/test78.root");
  if (fr) {
    std::cout << "The file was opened successfully." << std::endl;
    }
  else {
    // The file could not be opened.
    std::cout << "The file could not be opened." << std::endl;
    }

  //
  
  TTree *tr = (TTree*)fr->Get("rtree");

  RawEvent *revent = new RawEvent();
  
   //  TGraph *gr[10000];
  Int_t nevn =10;

  Int_t x[10000];
  Int_t y[10000];
  Int_t peakhigh[10000];
  Int_t vpeakhigh[10000];
  Int_t vpeaksum[10000];
  Int_t peaktime[10000];
  Int_t peaksum[10000];
  Int_t peaksumtime1[10000];
  Int_t peaksumtime2[10000];
  //  long long int bdsafasdf[10000][10000];
  vector<vector<Int_t>> ch_vpeakhigh ;
  vector<vector<Int_t>> ch_vpeakhigh_time_us ;
  vector<vector<Int_t>> ch_vpeakhigh_time_ns ;
  vector<vector<Long_t>>ch_vpeaksum0;
  vector<vector<Int_t>>ch_vpeaksum0_peak;
  vector<vector<Long_t>>ch_vpeaksum_tail;
  vector<vector<Long_t>>ch_vpeaksum_peak;
  vector<vector<Int_t>>ch_vpeaksum_time0_us;
  vector<vector<Double_t>>ch_vpeaksum_time1_ms;
  vector<vector<Double_t>>ch_vpeaksum_time1_us;
  vector<vector<Double_t>>ch_vpeaksum_time2_us;
  
  vector<vector<Int_t>>ch_vpeaksum_time0_ns(nevn);
  vector<vector<Int_t>>ch_vpeaksum_time1_ns(nevn);
  vector<vector<Int_t>>ch_vpeaksum_time2_ns(nevn);
  vector<vector<Double_t>>ch_peakhight(nevn);
  vector<vector<Int_t>>ch_time1_time2_ns(nevn);
  vector<vector<Int_t>>ch_PeakTimeDiff_ns(nevn);
  vector<vector<Int_t>>ch_vpeaksum(nevn);
  
  Int_t npeak_ch0[10000];
  Int_t npeak_ch1[10000];
  Int_t npeak_ch2[10000];
  Int_t npeak_ch3[10000];

  Int_t nsum_ch0[10000];
  Int_t nsum_ch1[10000];
  Int_t nsum_ch2[10000];
  Int_t nsum_ch3[10000];

  Int_t nraw[10000];
  Int_t raw_x[10000];
  Int_t raw_y[10000];
  
  
  int nevents = tr->GetEntries();
  //  fAmplitude[10000];
  vector<Double_t>fAmplitude;
  vector<Double_t>fTime;

  cout<<"N-------"<<nevents<<endl;


  TH1F* time_span = new TH1F(" ","time span of the signal ",100,0.0,500.0);
  TH1F* peakheight = new TH1F(" ","peak height of the signal_olddata ",100,-2200.0,0.0);
  TH1F* freq = new TH1F(" ","time interval b/w peaks ",100,1000.0,200000.0);
  TH1F* nopeak = new TH1F(" ","Number of peaks in each event",50,0.0,500.0);
  
  tr->SetBranchAddress("ch0.",&revent);
  printf("CH0 CH0 CH0 \n");
  
  for(int i= 0; i< nevn ;i++)
  //for(int i= 0; i< nevents ;i++)
  //for(int i= 0; i< 10 ;i++)
   { 
        tr->GetEntry(i);
	nraw[i] = revent->GetVAmpSize();
	//chsize = revent->GetVAmpSize();
	//printf("GetVAmpSize(): %f\n", revent -> GetVAmpSize());
	//printf("GetVPeakHighSize(): %f\n", revent -> GetVPeakHighSize());
	//printf("GetTime(): %f\n", revent -> GetVPeakHigh(2));
	//	printf("GetAmp(): %f\n", revent -> GetVAmp(2));
        npeak_ch0[i] = revent->GetVPeakHighSize();
        nsum_ch0[i] = revent->GetVPeakSumSize();
	cout<<"event sizes: "<<npeak_ch0[i]<<endl;
	nopeak->Fill(npeak_ch0[i]);
	
	//	fMp=revent->GetTime();
	// printf("event %d \t", i);
        // printf("nraw_ch0 = %d\t",nraw[i]);
        // printf("npeak_ch0 = %d\t",npeak_ch0[i]);
        // printf("nsum_ch0 = %d\n",nsum_ch0[i]);
	//fAmplitude.push_back(revent->GetAmp(i));
	//fTime.push_back(revent->GetTime(i));	
        for(int j =0; j< npeak_ch0[i];j++)  //counter=npeak_ch0
        {
	  // resize the vectors according to event content.
	  ch_peakhight[i].resize(npeak_ch0[i]);
	  ch_vpeaksum_time0_ns[i].resize(npeak_ch0[i]);
	  ch_vpeaksum_time1_ns[i].resize(npeak_ch0[i]);
	  ch_vpeaksum_time2_ns[i].resize(npeak_ch0[i]);
          ch_time1_time2_ns[i].resize(npeak_ch0[i]);
	  ch_vpeaksum[i].resize(npeak_ch0[i]);
	  
	  ch_vpeaksum_time0_ns[i][j]=revent->GetVPeakSumTime0()[j];
	  ch_vpeaksum_time1_ns[i][j]=revent->GetVPeakSumTime1()[j];
          ch_vpeaksum_time2_ns[i][j]=revent->GetVPeakSumTime2()[j];
	  ch_peakhight[i][j]=revent->GetVPeakHigh()[j];
          ch_vpeaksum[i][j]=revent-> GetVPeakSum()[j];
          ch_time1_time2_ns[i][j]=(revent->GetVPeakSumTime2()[j]-revent->GetVPeakSumTime1()[j]);

	  if (revent->GetVPeakHigh()[j]<0)
	    {
	      peakheight->Fill(revent->GetVPeakHigh()[j]);
	    }
	 
	  // if ((revent->GetVPeakSumTime2()[j])>(revent->GetVPeakSumTime1()[j]))
	  // {
	      time_span->Fill(revent->GetVPeakSumTime2()[j]-revent->GetVPeakSumTime1()[j]);
	      //cout<<"Time span: "<<revent->GetVPeakSumTime2()[j]-revent->GetVPeakSumTime1()[j]<<endl;
	      //  }
	  // cout<<"sedgffg"<<endl;
	  //fAmplitude[j]=revent->GetVAmp()[j];
	  //fMp=revent->GetVPeakSumTime1()[j];
	  
	  //cout<<"time1: "<<fMp<<endl;
	  //fTime[j]=revent->GetVTime()[j];
 	  //cout<<"event: "<<j<<" Amp: "<<revent->GetVAmp()[j]<<endl;
	  //cout<<"ch_vpeakhigh height: "<<ch_vpeakhigh.size()<<" ch_vpeakhigh width: "<<ch_vpeakhigh[0].size()<<endl;
	  //	  ch_vpeakhigh[i][j]=revent->GetVPeakHigh()[j];
	  //printf("Peak height: %f\n", revent -> GetVPeakHigh()[j]);
	  //printf("Peak heigh time (ns): %f\n", revent -> GetVPeakHighTime()[j]);
	  //printf("Peak sum0: %f\n", revent -> GetVPeakSum0()[j]);
	  //printf("Peak sum: %f\n", revent -> GetVPeakSum()[j]);
	  // printf("Peak sum tail: %f\n", revent -> GetVPeakSum_tail()[j]);
	  // printf("Peak sum peak: %f\n", revent -> GetVPeakSum0_peak()[j]);
	  //printf("Peak sum time0: %f\n", revent -> GetVPeakSumTime0()[j]);
	  //printf("Peak sum time1: %f\n", revent -> GetVPeakSumTime1()[j]);
	  //printf("Peak sum time2: %f\n", revent -> GetVPeakSumTime2()[j]);
	  //ch_vpeakhigh_time_us[i][j]=revent->GetVPeakHighTime()[j]*0.001; //convert to us
	  //ch_vpeakhigh_time_ns[i][j]=revent->GetVPeakHighTime()[j]; //ns
	   // hprof2d_vpeakheight_ms -> Fill(ch_vpeakhigh_time_us[i][j]*0.001,i,ch_vpeakhigh[i][j],1);

	   
       }               
       
   } //close nevn loop


	/*
       for(int j =0; j< nsum_ch0[i] ;j++)
       {
          ch_vpeaksum0[i][j]=revent->GetVPeakSum0()[j];
          ch_vpeaksum[i][j]=revent->GetVPeakSum()[j];
          ch_vpeaksum0_peak[i][j]=revent->GetVPeakSum0_peak()[j];

          ch_vpeaksum_time0_us[i][j]=revent->GetVPeakSumTime0()[j]*0.001; //convert to us
          ch_vpeaksum_time0_ns[i][j]=revent->GetVPeakSumTime0()[j]; //ns

          ch_vpeaksum_time1_ms[i][j]=revent->GetVPeakSumTime1()[j]*0.000001; //convert to ms
          ch_vpeaksum_time1_us[i][j]=revent->GetVPeakSumTime1()[j]*0.001; //convert to us
          ch_vpeaksum_time1_ns[i][j]=revent->GetVPeakSumTime1()[j]; //ns
          //printf("time sum1 = %d \t", ch_vpeaksum_time1_ns[i][j]);
          //printf("time sum0 = %d \t", ch_vpeaksum_time0_ns[i][j]);

          ch_vpeaksum_time2_us[i][j]=revent->GetVPeakSumTime2()[j]*0.001; //convert to us
          ch_vpeaksum_time2_ns[i][j]=revent->GetVPeakSumTime2()[j]; //ns
          //printf("time sum2 = %d \n", ch_vpeaksum_time2_ns[i][j]);


          hprof2d_vpeaksum_ms -> Fill(ch_vpeaksum_time1_ms[i][j],i,ch_vpeaksum[i][j],1);

             if(ch_vpeaksum_time1_us[i][j] < 3000)
               {
                hprof2d_vpeaksum_us_batch1 -> Fill(ch_vpeaksum_time1_us[i][j],i,ch_vpeaksum[i][j],1);
               } else if(ch_vpeaksum_time1_us[i][j] > 66000 && ch_vpeaksum_time1_us[i][j] < 69000)
               {
                hprof2d_vpeaksum_us_batch2 -> Fill(ch_vpeaksum_time1_us[i][j],i,ch_vpeaksum[i][j],1);
               } 
       }
      

  }
        
        
 
  
	*/

//For event=ev_n, estimate the waveform using a combined vector-------------------------
// plot histograms

  int ev_n = 2;
  
  int total_size = ch_vpeaksum_time0_ns[ev_n].size() *3;
  vector<Int_t>TimeV(total_size);

  vector<double> zer(ch_vpeaksum_time0_ns[ev_n].size());
  vector<double> zer2(ch_vpeaksum_time0_ns[ev_n].size());
  // Fill the vector with zeros
  
  std::fill(zer.begin(), zer.end(), 0.0);
    std::fill(zer2.begin(), zer2.end(), 0.0);
    cout<< "size height: "<<ch_peakhight[ev_n].size()<<" size time: "<<ch_vpeaksum_time0_ns[ev_n].size()<<" zero: "<<zer.size()<<endl;
    vector<Int_t>AmpViscos(total_size);

  auto combined_it = TimeV.begin();

 // Loop through the minimum size of the three vectors
  
  for (int ij = 0; ij < ch_vpeaksum_time0_ns[ev_n].size(); ++ij) {
    // Check if elements exist within each vector for the current index
    if (ij < ch_vpeaksum_time1_ns[ev_n].size()) {
      *combined_it = int(ch_vpeaksum_time1_ns[ev_n][ij]);
      // *combined_it2 = zer[ij];
      ++combined_it;
      //++combined_it2;
    }
    if (ij < ch_vpeaksum_time0_ns[ev_n].size()) {
      *combined_it = int(ch_vpeaksum_time0_ns[ev_n][ij]);
      //*combined_it2 = ch_peakhight[0][ij];
      ++combined_it;
      //++combined_it2;
    }
    if (ij < ch_vpeaksum_time2_ns[ev_n].size()) {
      *combined_it = int(ch_vpeaksum_time2_ns[ev_n][ij]);
      //*combined_it2 = zer[ij];
      ++combined_it;
      //++combined_it2;
    }
  }
  
  auto combined_itt = AmpViscos.begin();
 
  for (int jk = 0; jk < ch_peakhight[ev_n].size(); ++jk) {
    if (jk < zer.size()) {
        *combined_itt = zer[jk];
        ++combined_itt;
    }
    if (jk < ch_peakhight[ev_n].size()) {
        *combined_itt =ch_peakhight[0][jk];
        ++combined_itt;
    }
    if (jk < zer2.size()) {
        *combined_itt = zer2[jk];
        ++combined_itt;
    }
  }

  //find if time becomes 0.
  

    auto it = std::find(TimeV.begin(), TimeV.end(), 0);

    // If 0 is not found, the vector remains unchanged
    //if (it == TimeV.end()) {
    // return;
    //}

    TimeV.erase(it, TimeV.end());

    auto start = AmpViscos.begin() + TimeV.size(); 
    AmpViscos.erase(start,AmpViscos.end());
  
     
    cout<<"Final Time size: "<<TimeV.size()<<" Amp size: "<<AmpViscos.size()<<endl;

    //frequency estimation
    auto itt = std::find(ch_vpeaksum_time0_ns[ev_n].begin(), ch_vpeaksum_time0_ns[ev_n].end(), 0);
    ch_vpeaksum_time0_ns[ev_n].erase(itt,ch_vpeaksum_time0_ns[ev_n].end());

    for (int op=0;op<ch_vpeaksum_time0_ns[ev_n].size()-1;op++)
	{
	  freq->Fill(ch_vpeaksum_time0_ns[ev_n][op+1]-ch_vpeaksum_time0_ns[ev_n][op]);
	  // cout<<"time interval: "<<ch_vpeaksum_time0_ns[ev_n][op+1]-ch_vpeaksum_time0_ns[ev_n][op]<<endl;
	}
      

  // for (int klm=0;klm<TimeV.size();klm++)
  // {    cout<< "time values: "<<TimeV.at(klm)<<endl;}

  //   for (int kln=0;kln<ch_vpeaksum_time2_ns[0].size();kln++)
  // {    cout<< "time2 values: "<<ch_vpeaksum_time2_ns[0].at(kln)<<endl;}

    auto max_loc = std::max_element(TimeV.begin(), TimeV.end());
    int max_time = *max_loc;

   
  cout<<"Number of peaks: "<<ch_peakhight[ev_n].size()<<" maximum time: "<<max_time<<" ns"<<endl;
   
  TCanvas *c_prof_ns = new TCanvas("waveform ns","wf ns ",200,10,700,500);
  //TGraph *g = new TGraph(TimeV.size(),&TimeV[0],&AmpViscos[0]);
  TGraph *g = new TGraph(1000,&TimeV[0],&AmpViscos[0]);

  

  //c_prof_ms->cd();
  //hprof2d_vpeaksum_ms->Draw("colz");
  //  hprof2d_vpeakheight_ms->Draw("colz");
  // c_prof_us_batch1->cd();
  // hprof2d_vpeaksum_us_batch1->Draw("colz");

  // c_prof_us_batch2->cd();
  // hprof2d_vpeaksum_us_batch2->Draw("colz");


  g->SetTitle(Form("wavefom of event: %d",ev_n));
  g->Draw("ALP");

  // time_span->Draw();
  // peakheight->Draw("hist");
  //freq->Draw();
  //nopeak->Draw();
}

	
