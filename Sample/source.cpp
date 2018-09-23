#include <iostream>
#include "parser.h"
using namespace std;

extern int yyparse();
extern FILE *yyin;

int main(int argc, char *argv[])
{
	if(argc == 2)
		yyin = fopen(argv[1], "r");
	yyparse();
	return 0;
}

void yyerror(const char* msg)
{
	cout <<"Error: " <<msg << endl;
}