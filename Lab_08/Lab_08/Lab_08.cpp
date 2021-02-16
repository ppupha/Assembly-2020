// Lab_08.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
using namespace std;


double add_double(double a, double b)
{
	double c;
	__asm {
		finit; init coprocess
		fld		a; 
		fld		b; 
		fadd
		fstp	c; read from stack
	}
	return c;

}

double pow_double(double a, int pow)
{
	double res;
	__asm {
		finit;
		FLD1
		mov		ecx, pow;
		cmp		ecx, 0
		je		over
		pow_loop:
			fld		a;
			fmul;
			sub		ecx, 1;
			jne		pow_loop;
		over:
			fstp	res;	
	}
	return res;
}

double my_sum(double *array, int n)
{
	double sum = 0;
	size_t k = sizeof(double);
	size_t len = n * k;

	__asm{
		finit
		mov		ebx, array
		xor		esi, esi
		mov		ecx, len
		fldz; 0
		cmp		esi, ecx
		je		over
	loop_sum:
		fld	qword ptr[ebx + esi] // 8byte; st
		fadd; st(0) + st(1)
		add		esi, k
		cmp		esi, ecx          
		jl		loop_sum           
	over:
		fstp	sum         
	}
	return sum;
}


double test()
{
	double x = 2.0;
	double y = 0.5;
	double res = 5;
	double res1 = 0;
	__asm
	{
		fld res
		fld x
		fld y
		fdiv st, st(1)
		fld st(1)
		fstp res
		fstp res1
	}
	cout << "res1 = " << res1 << endl;
	cout << "res = " << res << endl;
	return res;
}

int main()
{
	float c = add_double(10.3, 10.2);
	
	cout << "c = " << c << endl;

	c = pow_double(5.6, 3);
	cout << "C = " << c << endl;

	double arr[] = { 1.0, 2.0, 3.0, 4.0, 5.7};

	double res = my_sum(arr, 5);
	cout << "Calc = " << res << endl;


    return 0;
}

