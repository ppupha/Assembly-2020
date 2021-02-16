// Lab09.cpp : This file contains the 'main' function. Program execution begins and ends there.
//
#include <iostream>

int stringlen(char* str)
{
	int len = 0;
	while (str[len])
		len++;
	return len;
}

bool my_isNum(char ch)
{
	return '0' <= ch && ch <= '9';
}

int main()
{
	char a[100];
	std::cout << "Enter A String: ";
	std::cin >> a;

	char b[100];
	int lenb = 0;

	int len = strlen(a);

	for (int i = 0; i < len; i++)
	{
		if (my_isNum(a[i]))
		{
			b[lenb++] = a[i];
		}
	}

	b[lenb++] = 0;

	if (strcmp(b, "01062020") == 0)
		std::cout << "OK";
	else
		std::cout << "FAILED";
}
