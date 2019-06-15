#pragma once
#include <fstream>

using namespace std;

void transformFile(ifstream & fin, ofstream & fout, bool file_is_long = true, string name = "");
void transformCoefficients(string, string);
void transformForL2(string, string);
void transformForF23(string, string);
void transformAll(string folderNameIn = "C:\\Users\\Елизавета\\UNI\\CV\\SFM\\MATLAB\\", string folderNameOut = "C:\\Users\\Елизавета\\UNI\\CV\\SFM\\ConsoleApplication1\\findingFundamental\\");