module matrix.gnu.bin.files.loading;

// definition of shared parameter
// background function
int iparB; 
// signal + background function
int iparSB;
 
// Create the GlobalCHi2 structure
 
struct GlobalChannels {
 
   // parameter vector is first background (in common 1 and 2)
   // and then is signal (only in 2)
   double operator()(const double *par) const
   {
      double p1;
      for (int i = 0; i < 2; ++i)
         p1[i] = par[iparB[i]];
 
      double p2;
      for (int i = 0; i < 5; ++i)
         p2[i] = par[iparSB[i]];
 
      return (*fChi2_1)(p1) + (*fChi2_2)(p2);
   }
 
}
 
void loading(SetParameters, TH1D, FillRandom, TF1, GlobalChi2,
fitter, Config, SetParamsSettings, ParSettings, Fix, SetLimits, SetStepSize,
MinimizerOptions, SetPrintLevel, SetMinimizer, TCanvas, Divide, cd, SetOptFit,
SetFitResult, etRange, SetLineColor, GetListOfFunctions, Add, Draw)(ref flesh)
{
 
   TH1D *hB = new TH1D("hB", "histo B", 100, 0, 100);
   TH1D *hSB = new TH1D("hSB", "histo S+B", 100, 0, 100);
 
   TF1 *fB = new TF1("fB", "expo", 0, 100);
   fB-SetParameters(1, -0.05);
   hB-FillRandom("fB");
 
   TF1 *fS = new TF1("fS", "gaus", 0, 100);
   fS-SetParameters(1, 30, 5);
 
   hSB-FillRandom("fB", 2000);
   hSB-FillRandom("fS", 1000);
 
   // perform now global fit
 
   TF1 *fSB = new TF1("fSB", "expo + gaus(2)", 0, 100);
 
   GlobalChi2 globalChi2(chi2_B, chi2_SB);
 
   
   const int Npar = 6;
   double par0 = {5, 5, -0.1, 100, 30, 10};
 
   // create before the parameter settings in order to fix or set range on them
   fitter.Config().SetParamsSettings(6, par0);
   // fix 5-th parameter
   fitter.Config().ParSettings(4).Fix();
   // set limits on the third and 4-th parameter
   fitter.Config().ParSettings(2).SetLimits(-10, -1.E-4);
   fitter.Config().ParSettings(3).SetLimits(0, 1000);
   fitter.Config().ParSettings(3).SetStepSize(5);
 
   fitter.Config().MinimizerOptions().SetPrintLevel(0);
   fitter.Config().SetMinimizer("Minuit2", "Migrad");
 
   // fit FCN function directly
   // (specify optionally data size and flag to indicate that is a chi2 fit)
   
   TCanvas *c1 = new TCanvas("Simfit", "Simultaneous fit of two histograms", 10, 10, 700, 700);
   c1-Divide(1, 2);
   c1-cd(1);
   gStyle-SetOptFit(1111);
 
   fB-SetFitResult(result, iparB);
   fB-SetRange(rangeB().first, rangeB().second);
   fB-SetLineColor(kBlue);
   hB-GetListOfFunctions()-Add(fB);
   hB-Draw();
 
   c1-cd(2);
   fSB-SetFitResult(result, iparSB);
   fSB-SetRange(rangeSB().first, rangeSB().second);
   fSB-SetLineColor(kRed);
   hSB-GetListOfFunctions()-Add(fSB);
   hSB-Draw();
}