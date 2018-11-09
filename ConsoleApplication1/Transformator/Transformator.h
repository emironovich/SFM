#pragma once
#include <fstream>
#include <string>
using namespace std;

class Transformator
{
private:
	string folderNameIn;
	string folderNameOut;
public:
	Transformator(string folderNameIn, string folderNameOut);
	~Transformator();
	void transformFile(ifstream & fin, ofstream & fout, string name, bool no_new_lines = false);
	void transformCoefficients();
	void transformForL2(); //when it calls transformFile() something goes super wrong !!! 
	void transformForF23();
	void transformAll();
};

