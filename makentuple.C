void makentuple() {
//
// Macro to create a simple ntuple-like TTree reading data from an ascii file.
// This derives from basic2.C in tutorials/tree 
//

   TString dir = gSystem->UnixPathName(gInterpreter->GetCurrentMacroName());
   dir.ReplaceAll("makentuple.C","");
   dir.ReplaceAll("/./","/");
   
   TFile *f = new TFile("gptuple.root","RECREATE");  
   TTree *T = new TTree("ntuple","data from ascii file");

   Long64_t nlines = 
   T->ReadFile(Form("%slumi.ee.out",dir.Data()),"E1:E2:x:y:z:time:x1p:y1p:x2p:y2p:P1x:P1y:P1z:P2x:P2y:P2z:id");
   printf(" found %lld points\n",nlines);
//   T->Draw("2.0*sqrt(E1*E2)");
   T->Write();
   
}
