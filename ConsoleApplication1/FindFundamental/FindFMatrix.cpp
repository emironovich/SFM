#include "coeffsFinders.h"
#include <Eigen/Dense>

using namespace std;
using namespace Eigen;

MatrixXd FindFMatrix(double * x, double * y, double * xx, double * yy) {
	MatrixXd M(10, 16); // coefficient matrix for ten equations and sixteen monomials
	fillM(M, x, y, xx, yy);

	//M.colPivHouseholderQr(); //???? пофиг
	gaussElimination(M); // THIS DOES NOT WORK OF COURSE

	 
	MatrixXd Q(10, 6); // this is the "leftovers" of gaussian elimination, six left colomns that are beside an identity matrix
	for (int i = 0; i < 10; i++) {
		for (int j = 0; j < 6; j++) {
			Q(i, j) = M(i, j + 10);
		}
	}

	MatrixXd Q(10, 6);
	VectorXd poly(11);

	find_coefficients(poly, Q);

	
	MatrixXd C = MatrixXd::Zero(10,10); //the companion matrix
	C(0, 9) = poly(0) / poly(10); // todo find out the way of numeration
	for (int i = 1; i < 10; i++) {
		C(i, i - 1) = 1;
		C(i, 9) = poly(i) / poly(10);
	}

	//find its eigenvalues = roots of poly
	VectorXd values = C.eigenvalues(); //todo this is a 10th degree polynomial how do we get one L2 if there are 10 roots???

	
	//find lambda 1
	double L1 = find_L1(values); //get from values vector

	//find lambda 2
	double L2 = find_L2(L1); //todo and this is a 2nd degree polynomial!!

	Matrix3d F;
	//find F[2][3] supposing that F[3][3] = 1
	F(2, 3) = findF23(Q, L1, L2);
	F(3, 3) = 1;

	//find all the other coefficents of the matrix F

	VectorXd X(6);
	X(0) = L2 * F(2, 3);
	X(1) = F(2, 3);
	X(2) = F(3, 3);
	X(3) = L1 * F(3, 3);
	X(4) = L2 * F(3, 3);
	X(5) = L1 * L2 * F(3, 3);

	F(1, 1) = Q.row(0) * X;
	F(1, 2) = Q.row(1) * X;
	F(2, 1) = Q.row(2) * X;
	F(2, 2) = Q.row(3) * X;
	F(3, 1) = Q.row(5) * X;
	F(3, 2) = Q.row(7) * X;
	F(1, 3) = Q.row(9) * X;



	return F;
}