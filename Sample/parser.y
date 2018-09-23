%defines "parser.h"

%{
	#include <cmath>
	#include <cstdio>
	#include <iostream>

	#pragma warning (disable: 4005)
	
	// this function will be generated
	// by flex
	extern int yylex(); // lexical analyzer
	 
	 // we have to code this function
	extern void yyerror(const char*);

	using namespace std;
%}

%define api.value.type { double }

%token NUM WHILE DO ALLAV CLLAV FINLIN
%start instrucciones 

%left '-' '+'
%left '*' '/'

%%		/* the grammars here */

instrucciones : instruccion | instrucciones;
instruccion : dowhile FINLIN 
			| NUM FINLIN { cout << " =>" << $1 << endl; }
			;

dowhile : dowhilesing | dowhilemult;
dowhilesing : DO
			  instruccion	
			  WHILE '(' condicion ')'
			  ;
dowhilemult : DO ALLAV
			  instrucciones	
			  CLLAV WHILE '(' condicion ')'
			  ;

condicion : NUM;

input: %empty
	| input line
	;

line: '\n'
	| exp '\n'	{ cout << " =>" << $1 << endl; }
	; 

exp: NUM		   { $$ = $1; }
	| exp '+' exp  { $$ = $1 + $3; }
	| exp '-' exp  { $$ = $1 - $3; }
	| exp '*' exp  { $$ = $1 * $3; }
	| exp '/' exp  { $$ = $1 / $3; }
	| '(' exp ')'  { $$ = $2; }
	;

%%
