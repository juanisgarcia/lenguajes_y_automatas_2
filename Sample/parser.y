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

instrucciones: %empty
	   | instrucciones line
	   ;
instruccion : while  
			| line
			;
instruccion : dowhile  
			| line
			;
while : WHILE
		  	
		   '(' condicion ')' 
			 ALLAV
		  		instrucciones	
		 	 CLLAV
			;
			
dowhile : DO		
		  instrucciones	
		  WHILE '(' condicion ')' FINLIN
		  |
		  DO ALLAV
		  instrucciones	
		  CLLAV WHILE '(' condicion ')' FINLIN
		  ;

condicion : NUM;

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
