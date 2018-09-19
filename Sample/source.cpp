#include <iostream>
#include "parser.h"
using namespace std;

extern int yyparse();

int main()
{
	yyparse();
	return 0;
}

void yyerror(const char* msg)
{
	cout <<"Error: " <<msg << endl;
}