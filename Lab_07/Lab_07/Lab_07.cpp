// Lab_07.cpp : Defines the entry point for the console application.
//

#pragma warning
#include "stdafx.h"

#include <iostream>
using namespace std;
#include <string>
#include <string.h>


extern "C"
{
	int stringlen(char *str);
	void testAsm();
	int strcopy(char * str1, int len, char *str2);
}

int my_strlen(char *string)
{
	__asm
	{
		mov 	edi, string
		xor		ecx, ecx
		not		ecx
		xor		al, al
		cld
		repne	scasb
		not		ecx
		lea		eax, [ecx - 1]
	}
}

int main()
{
	int len = 0;
	char *str1 = "123456789";
	__asm {
		mov		edi, str1
		xor		ecx, ecx
		not ecx
		xor		al, al
		cld //
		repne	scasb // = al ECX = 0 scan byte EDI = al
		// compare with al
		// if (== al)
		// setflaf zF = 1
		// E
		not		ecx
		lea		eax, [ecx - 1]

		mov		len, eax
	}

	cout << "\nString:[" << str1 <<"]" << endl;
	cout << "len =        " << len << endl;
	cout << "Len =        " << stringlen(str1) << endl;
	cout << "Len(strlen)= " << strlen(str1) << endl;
	cout << "Len =        " << my_strlen(str1) << endl;
	//testAsm();
	cout << endl;
	char *str2 = new char[20];
	char * str3 = "1234567890";
	
	/*strcopy(str2, 10, "abcdfghijklmnop");
	cout << "Str2: [" << str2 <<"]"<< endl;
	cout << "Len Str2: " << my_strlen(str2) << endl;
	strcopy(str2 + 2, 5, str2);
	cout << "Str2: ["<< str2 << "]" << endl;
	cout << "Len Str2: " << my_strlen(str2) << endl;*/

	strcopy(str2, 0, str3);
	cout << "str2 = [" << str2 << "]" << endl;

	strcopy(str2, strlen(str3), str3);
	cout << "str2 = [" << str2 << "]" << endl;
	strcopy(str2, 100, str3);
	cout << "str2 = [" << str2 << "]" << endl;

	strcopy(str2 + 2, 5, str2);

	cout << "str2 = [" << str2 << "]" << endl;
	strcopy(str2, 100, str3);
	strcopy(str2, 5, str2 + 2);
	cout << "str2 = [" << str2 << "]" << endl;

	return 0;
}

