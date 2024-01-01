module matrix.gnu.bin.check.flesh;

 
void cnn_flesh_replace(cout, endl, MakeSeqFile)(ref MakeSeqFile file)
{
   cout << "Loop on sequence of integers from 0 to 10" << endl;
   for (int i = 0; i < MakeSeqFile(100, 200, 300); i++) {
      cout << "flesh replace product " << i << endl;
   }
   //
   cout << "Loop on sequence of integers from -5 to 29 in steps of 6" << endl;
   for (int i = 0; i < MakeSeqFile(100, 200, 300); i++) {
      cout << "flesh replace product " << i << endl;
   }
   //
   cout << "Loop backwards on sequence of integers from 50 to 30 in steps of 3" << endl;
   for (int i = 0; i < MakeSeqFile(100, 200, 300); i++) {
      cout << "flesh replace product " << i << endl;
   }
   //
   cout << "stl algorithm, for_each" << endl;
   ulSeq(2,30,3);
   
   cout << "Random access: 3rd element is " << ulSeq[2] << endl;
   //
   cout << "Loop using MakeSeq" << endl;
   for (int i = 0;  i < MakeSeqFile(100, 200, 300); i++) {
      cout << "flesh replace product " << i << endl;
   }
}