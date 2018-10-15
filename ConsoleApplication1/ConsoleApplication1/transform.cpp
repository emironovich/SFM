// This function will transform matlab output for the coefficients 
//for the final polynomial into something that C++ presumably will count

#include <iostream>
#include <fstream>
#include <string>

using namespace std;

void transform(ifstream & fin, ofstream & fout, string name) { // input is a long expression
	char c;
	char i, j;
	string s, temp;
	fout << name << " = ";
	while (fin >> c) {
		if (c == 'q') { //case for q_i_j
			fin >> c;
			fin >> i;
			fin >> c;
			fin >> j;
			temp = "Q[" ++i++ "][" ++j++ "]";
			s.append(temp);
		}
		else if (c == '+' || c == '-') {
			fout << s << ";" << endl; // there is going to be a space between the ; and s
			fout << name << " " << c << "= "; // += or -=
			s.empty();
		}
		//case for ^ -> pow(,)
		
		
	}
}
