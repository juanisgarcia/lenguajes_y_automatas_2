
%defines "parser.h"

%{
	#include <cmath>
	#include <cstdio>
	#include <iostream>


	// this function will be generated
	// by flex
	extern int yylex(); // lexical analyzer
	 
	 // we have to code this function
	extern void yyerror(const char*);

	using namespace std;
%}

%define api.value.type { double }

%token NUM WHILE DO ALLAV CLLAV FINLIN SWITCH CASE BREAK DEFAULT FOR INCPOS INCNEG
%start instrucciones 

%left '-' '+'
%left '*' '/'

%%		/* the grammars here */

instrucciones: %empty
	   | instrucciones instruccion
	   ;

instruccion : dowhile  
		| switch 
			| line
			| while
                        | for
			;
while : WHILE
		  	
		   '(' condicion ')' 
			 ALLAV
		  		instrucciones	
		 	 CLLAV
			;
			
dowhile : DO		
		  instrucciones	
		  WHILE '(' condicion ')' FINLIN {cout <<"Do while de una sola instrucción"<<endl;}
		  |
		  DO ALLAV
		  instrucciones	
		  CLLAV WHILE '(' condicion ')' FINLIN {cout <<"Do while de una muchas instrucciones"<<endl;}
		  ;

switch : SWITCH '(' identificador ')'ALLAV
		cases
		default
		CLLAV;
cases: cases CASE NUM ':'
		instrucciones
		BREAK FINLIN {cout <<"esto es un switch";}
		|
		%empty;
default: DEFAULT ':'
		instrucciones
		|
		%empty;

for : 				 
		 FOR  '('asignacion FINLIN condicion FINLIN incremento')'  
                 ALLAV
		 instrucciones
	         CLLAV {cout << "Esto es un ciclo for"<< endl;}

asignacion:NUM;
incremento:identificador INCPOS | identificador INCNEG ;
                          			  
condicion : NUM;
identificador : NUM;

line: exp FINLIN { cout << " =>" << $1 << endl; }
	; 
exp: NUM		   { $$ = $1; }
	| exp '+' exp  { $$ = $1 + $3; }
	| exp '-' exp  { $$ = $1 - $3; }
	| exp '*' exp  { $$ = $1 * $3; }
	| exp '/' exp  { $$ = $1 / $3; }
	| '(' exp ')'  { $$ = $2; }
	;

%%



