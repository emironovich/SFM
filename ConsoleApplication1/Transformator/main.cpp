// Transformator.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <iostream>
#include "transformers.h"
#include "Transformator.h"

using namespace std;

int main()
{
	Transformator t("C:\\Users\\Елизавета\\UNI\\CV\\SFM\\MATLAB\\", "C:\\Users\\Елизавета\\UNI\\CV\\SFM\\ConsoleApplication1\\FindFundamental\\");
	t.transformAll();
    return 0;
}

