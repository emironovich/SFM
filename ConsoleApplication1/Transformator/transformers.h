#pragma once
#include <fstream>

using namespace std;

void transformFile(ifstream & fin, ofstream & fout, bool file_is_long = true, string name = "");
void transformCoefficients();
void transformForL2();
void transformForF23();
void transformAll();