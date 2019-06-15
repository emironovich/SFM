#include <fstream>
#include <string>

using namespace std;

int main()
{
	ifstream fin("C:\\Users\\Елизавета\\UNI\\CV\\SFM\\MATLAB\\R.txt");
	ofstream fout("C:\\Users\\Елизавета\\UNI\\CV\\SFM\\MATLAB\\find_R_num.m");
	fout << "\% elemets of matrix R(i, j, :) are polynomial coefficients" << endl;
	fout << "function R = find_R_num(Q)" << endl;
	fout << "\tR = zeros(4, 4, 4);" << endl;
	char c;
	char i, j, z;
	string s, temp;
	bool readSign;
	for (int ind = 1; ind <= 4; ++ind) {
		for (int jnd = 1; jnd <= 4; ++jnd) {
			readSign = true;
			fout << "\tR(" << ind << ", " << jnd << ", :) = [";
			if (ind >= 3) {
				fout << "0, ";
			}
			fin >> c;
			while (c != '$') {
				if (c == '0') {
					s.append("0, 0, 0, 0");
				}
				else if (c == 'q') { //case for q_i_j
					if (!readSign) {
						s.append(",...\n\t\t");
					}
					fin >> c; // "_"
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
					temp = "Q(";
					if (z == '0') {
						temp.append("10");
					}
					else {
						temp.push_back(i);
					}
					temp += ", ";
					temp.push_back(j);
					temp.push_back(')');
					s.append(temp);
					temp.clear();
					readSign = false;
				}
				else {
					readSign = true;
					s.push_back(c);
				}
				fin >> c;
			}
			fout << s;
			s.clear();
			fout << "];" << endl;
		}
	}

	fout << "end";
	return 0;
}