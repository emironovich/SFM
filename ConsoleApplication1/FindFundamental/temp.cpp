#include "stdafx.h"
#include <Eigen/Dense>

using namespace Eigen;

void findCoefficientsForL2Poly(double * L2, MatrixXd & Q, double L_1) {}
void findCoefficientsForF23(double ** F, MatrixXd & Q, double L_1, double L_2) {}
void find_0_coefficient(double & X, MatrixXd & Q) {}
void find_1_coefficient(double & X, MatrixXd & Q) {}
void find_2_coefficient(double & X, MatrixXd & Q) {}
void find_3_coefficient(double & X, MatrixXd & Q) {}
void find_4_coefficient(double & X, MatrixXd & Q) {}
void find_5_coefficient(double & X, MatrixXd & Q) {}
void find_6_coefficient(double & X, MatrixXd & Q) {}
void find_7_coefficient(double & X, MatrixXd & Q) {}
void find_8_coefficient(double & X, MatrixXd & Q) {}
void find_9_coefficient(double & X, MatrixXd & Q) {}
void find_10_coefficient(double & X, MatrixXd & Q) {}
double find_L2(double L1) { return 0; }
double find_L1(VectorXd & values) { return 0; }

void gaussElimination(MatrixXd & M) {
	for (int i = 0; i < 10; i++) {
		double t = M(i, i);
		for (int j = i; j < 16; j++) {
			M(i, j) /= t;
		}
		for (int j = 0; j < 10; j++) {
			if (j == i)
				continue;
			t = M(j, i);
			for (int k = i; k < 16; k++) {
				M(j, k) = M(j, k) / t - M(i, k);
			}
		}
	}
}
double findF23(MatrixXd & Q, double L1, double L2) { return 0; }
void find_coefficients(VectorXd & poly, MatrixXd & Q) {
	find_0_coefficient(poly(0), Q);
	find_1_coefficient(poly(1), Q);
	find_2_coefficient(poly(2), Q);
	find_3_coefficient(poly(3), Q);
	find_4_coefficient(poly(4), Q);
	find_5_coefficient(poly(5), Q);
	find_6_coefficient(poly(6), Q);
	find_7_coefficient(poly(7), Q);
	find_8_coefficient(poly(8), Q);
	find_9_coefficient(poly(9), Q);
	find_10_coefficient(poly(10), Q);
}
void fillM(MatrixXd M, double * x, double * y, double * xx, double * yy) {
	for (int i = 0; i < 10; i++) { // THIS IS PROBABLY WRONG

		//f11, f12, f21, f22, l1f31, f31, l1f32, f32, l2f13, f13, l2f23, f23, f33, l1f33, l2f33, l1l2f33
		//0 1 4 5 8 9 10 11 2 3 6 7 15 13 14 12

		M(i, 0) = x[i] * xx[i];  //  f_1_1, 
		M(i, 1) = x[i] * yy[i]; // f_1_2, 
		M(i, 2) = xx[i] * y[i]; // f_2_1; 
		M(i, 3) = y[i] * yy[i]; // f_2_2; 	
		M(i, 4) = xx[i] * (pow(x[i], 2) + pow(y[i], 2)); //  L_1*f_3_1; 
		M(i, 5) = xx[i]; // f_3_1;
		M(i, 6) = yy[i] * (pow(x[i], 2) + pow(y[i], 2)); //  L_1*f_3_2; 
		M(i, 7) = yy[i]; // f_3_2;
		M(i, 8) = x[i] * (pow(xx[i], 2) + pow(yy[i], 2)); // L_2*f_1_3; 
		M(i, 9) = x[i]; // f_1_3; 
		M(i, 10) = y[i] * (pow(xx[i], 2) + pow(yy[i], 2)); // L_2*f_2_3; 
		M(i, 11) = y[i]; // f_2_3;
		M(i, 12) = 1; // f_3_3
		M(i, 13) = pow(x[i], 2) + pow(y[i], 2);  // L_1*f_3_3;
		M(i, 14) = pow(xx[i], 2) + pow(yy[i], 2);  //  L_2*f_3_3; 
		M(i, 15) = (pow(x[i], 2) + pow(y[i], 2))*(pow(xx[i], 2) + pow(yy[i], 2)); //  L_1*L_2*f_3_3; 	
	}
}