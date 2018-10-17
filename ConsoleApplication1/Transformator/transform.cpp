// This function will transform matlab output for the coefficients 
//for the final polynomial into something that C++ presumably will count

#include "stdafx.h"
#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>

using namespace std;

void transformFile(ifstream & fin, ofstream & fout, bool file_is_long = false, string name = "") {
	char c;
	char i, j, z;
	char p;
	string s, temp;
	if(file_is_long)
		fout << name << " = ";
	while (fin >> c) {
		if (c == 'q') { //case for q_i_j
			fin >> c;
			fin >> i;
			fin >> c;
			if (c != '_') { // 1 <= i <= 10
				z = c;
				fin >> c;
			}
			else {
				z = '1';
			}
			fin >> j;
			temp = "Q[";
			if (z == '0') {
				temp.push_back('9');
			}
			else {
				temp.push_back(i - 1);
			}
			temp += "][";
			temp.push_back(j - 1);
			temp.push_back(']');
			s.append(temp);
			temp.clear();
		}
		else if ((c == '+' || c == '-') && file_is_long) {
			//s.pop_back(); //presumably there will be spaces between symbols
			fout << s << ";" << endl; 
			fout << name << " " << c << "= "; // += or -=
			s.clear();
		}
		else if (c == '^') { //case for ^ -> pow(,)
			// there are no spaces surrounding ^
			fin >> p; //power
			i = '^';
			while (i != 'Q') {
				i = s.back();
				s.pop_back();
				temp.push_back(i);
			}
			reverse(temp.begin(), temp.end());
			s += "pow(" + temp + ", " + p + ")";
			temp.clear();
		}
		else if (c == ';') {
			fout << s << ';' << endl;
			s.clear();
		}
		else {
			s.push_back(c);
		}
	}
	fout << s;
	fout << ";" << endl;
}

void transformCoefficients() {
	ifstream fin;
	ofstream fout;
	string fileNameIn, fileNameOut, numString;
	for (int i = 0, num = '0'; i < 11; i++, num++) {
		if (i != 10)
			numString = num;
		else
			numString = "10";
		fileNameIn = "C:\\Users\\Елизавета\\UNI\\CV\\SFM\\MATLAB\\poly" + numString + ".txt";
		fin.open(fileNameIn);

		fileNameOut = "poly" + numString + ".cpp";
		fout.open(fileNameOut);

		fout << "#include \"stdafx.h\"" << endl << "#include <cmath>" << endl << endl;
		fout << "void find_" << (num - '0') << "_coefficient(double & X) {" << endl;
		transformFile(fin, fout, true, "X");
		fout << "}";

		fin.close();
		fout.close();
	}
}

void transformForL2() {
	ifstream fin("C:\\Users\\Елизавета\\UNI\\CV\\SFM\\MATLAB\\coeffs_for_L2.txt");
	ofstream fout("coeffsL2.cpp");
	fout << "#include \"stdafx.h\"" << endl  << "#include <cmath>" << endl << endl;
	fout << "void findCoefficientsForL2Poly(double * L2, double ** Q, double L1) {" << endl;
	transformFile(fin, fout);
	fout << "}";
	fin.close();
	fout.close();
}

void transformForF23() {
	ifstream fin("C:\\Users\\Елизавета\\UNI\\CV\\SFM\\MATLAB\\coeffs_for_F_2_3.txt");
	ofstream fout("findF23.cpp");
	fout << "#include \"stdafx.h\"" << endl << "#include <cmath>" << endl << endl;
	fout << "void findCoefficientsForF23(double ** F, double ** Q, double L1, double L2) {" << endl;
	transformFile(fin, fout);
	fout << "}";
	fin.close();
	fout.close();
}

void transformAll() {
	transformCoefficients();
	transformForL2();
	transformForF23();
}
