#include "stdafx.h"
#include <cmath>

void findCoefficientsForF23(double ** F, double ** Q, double L1, double L2) {
F[2][3]=-(Q[4][2]-L_1*Q[5][2]+L_1*(Q[4][3]-L_1*Q[5][3])+L_2*(Q[4][4]-L_1*Q[5][4])+L_1*L_2*(Q[4][5]-L_1*Q[5][5]))/(Q[4][1]-L_1*Q[5][1]+L_2*(Q[4][0]-L_1*Q[5][0]));
}