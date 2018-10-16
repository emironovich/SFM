// This function will transform matlab output for the coefficients 
//for the final polynomial into something that C++ presumably will count

#include "stdafx.h"
#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>

using namespace std;

void transform(ifstream & fin, ofstream & fout, string name) { // input is a long expression
	char c;
	char i, j, z;
	char p;
	string s, temp;
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
		else if (c == '+' || c == '-') {
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
		else {
			s.push_back(c);
		}
	}
	fout << s;
	fout << ";" << endl;
}
