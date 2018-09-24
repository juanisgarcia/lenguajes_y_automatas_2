%option noyywrap

%{ 
	
	#pragma warning (disable: 4005)

	#include <iostream>
	#include <cmath>

	using namespace std;

	#include "parser.h"

%}

NUMB	([0-9]+)|([0-9]*\.[0-9]+)

%%

{NUMB}			{ yylval = atof(yytext); return NUM; }
[+*/()-:]		{ return yytext[0]; }

"while"			{return WHILE;}
"do"			{return DO;}
"switch"		{return SWITCH;}
"case"			{return CASE;}
"break"			{return BREAK;}
"default"		{return DEFAULT;}

"{"			{ return ALLAV; }
"}"			{ return CLLAV; }
";"			{ return FINLIN; }
[\n]			{ /* empty */ }
[ \t]			{ /* empty */ }
"quit"			{ yyterminate(); }
.				/* nothing, eat up */


