%{
#define YYDEBUG 1

#include <stdlib.h>

extern int yylineno;
extern char *yytext;

#include "datastructure.h"
extern void yyerror(const char *msg);
extern int yylex();

%}

%union {
  struct ComplexNode* ast_fc;
}
				
%type <ast_fc> VAL_INT VAL_NUM VAL_STRING potentialvalue
%type <ast_fc> fcall SETCOLOR SETFONT SETLINEWIDTH SETDRAWSTYLE ARC ELLIPSE STRING2PATH DRAW FILL
%type <ast_fc> command IDENTIFIER program commands list

%token PICTURE IDENTIFIER START END
%token VAR
%token TYPE
%token FOR TO VAL_INT STEP DO DONE
%token VAL_NUM VAL_LINESHAPE VAL_STRING
%token FCALLPREFIXOPEN

%token SETCOLOR SETDRAWSTYLE SETFONT SETLINEWIDTH ARC ELLIPSE PLOT STRING2PATH CONCAT UNION SCALETOBOX DRAW FILL NUM2STRING WRITE ROTATE SCALE TRANSLATE CLIP
%token SIN COS RANDOM EXP ABS LN

%token ASGN ":=" 
%token ASGN_LATE "<-"
%token LBLB "<<"
%token RBRB ">>"
%token MOD "mod"

%left '+' '-'
%left '*' '/' "mod"

%expect 0
%error-verbose



%%

program 				: PICTURE VAL_STRING declarations START commands END	{$5->printCode();}
        				;
	
declarations  	: %empty
              	| declarations declaration 
              	;
	
declaration   	: VAR list ':' TYPE ';'
              	;
	
commands      	: %empty																{$$=new ComplexNode();}
              	| commands command											{$$=(new ComplexNode($1))->append($2);delete $1; $1=nullptr;delete $2; $2=nullptr;}
              	;
	
command       	:  IDENTIFIER ":=" potentialvalue  ';'																														{$$=(new ComplexNode())->earlybinding($1,$3);delete $1;$1=nullptr;delete $3;$3=nullptr;}	 /*2*/
              	|  IDENTIFIER "<-" potentialvalue  ';'																														{$$=(new ComplexNode())->latebinding($1,$3);delete $1;$1=nullptr;delete $3;$3=nullptr;}	/*2*/
              	|  fcall ';'  																																										{$$=(new ComplexNode($1));										delete $1;$1=nullptr;											} /*1*/
              	|  FOR IDENTIFIER ":=" potentialvalue TO potentialvalue STEP potentialvalue DO commands DONE ';'  {$$=(new ComplexNode())->forloop($2, $4, $6, $8, $10);delete $2;$2=nullptr;delete $4;$4=nullptr;delete $6;$6=nullptr;delete $8;$8=nullptr;delete $10;$10=nullptr;} /*1*/
              	|  IDENTIFIER ';' 																																								{$$=new ComplexNode($1);delete $1, $1=nullptr;} /* for Terms */
              	;
	
fcall         	:  SETCOLOR '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'							                                              {$$=(new ComplexNode())->setcolor($3,$5,$7);				$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  SETDRAWSTYLE '(' potentialvalue ',' potentialvalue ')'             							                                                {$$=(new ComplexNode())->setdrawstyle($3,$5);				$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  SETFONT '(' potentialvalue ',' potentialvalue ')'		                                                                            {$$=(new ComplexNode())->setfont($3,$5);						$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  SETLINEWIDTH '(' potentialvalue ')'		                                                                                          {$$=(new ComplexNode())->setlinewidth($3);					$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  ARC '(' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ')'  		                                        {$$=(new ComplexNode())->arc($3,$5,$7,$9);					$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  ELLIPSE '(' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ')'  		                  {$$=(new ComplexNode())->ellipse($3,$5,$7,$9,$11);	$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  PLOT '(' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ')'		    {std::cout<<"not to be implemented"<<std::flush;																													 }                                 
			  				|  STRING2PATH '(' potentialvalue ',' potentialvalue ')'		                                                                        {$$=(new ComplexNode())->string2path($3,$5);				$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  CONCAT '(' potentialvalue ',' potentialvalue ')'		                                                                              {std::cout<<"not to be implemented"<<std::flush;																													 }         
			  				|  UNION '(' potentialvalue ',' potentialvalue ')'		                                                                              {std::cout<<"not to be implemented"<<std::flush;																													 }         
			  				|  SCALETOBOX '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'		                                                      {std::cout<<"not to be implemented"<<std::flush;																													 }         
			  				|  DRAW '(' potentialvalue ')'		                                                                                                  {$$=(new ComplexNode())->draw($3);									$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  FILL '(' potentialvalue ')'		                                                                                                  {$$=(new ComplexNode())->fill($3);									$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  NUM2STRING '(' potentialvalue ')'		                                                                                            {$$=(new ComplexNode())->num2string($3);delete $3;$3=nullptr;}
			  				|  WRITE '(' potentialvalue ')'		                                                                                                  {$$=(new ComplexNode())->write($3);delete $3;$3=nullptr;}
			  				|  WRITE '(' potentialvalue ',' potentialvalue ')'		                                                                              {$$=(new ComplexNode())->write($3,$5);delete $3;$3=nullptr;delete $5;$5=nullptr;}
			  				|  ROTATE '(' potentialvalue ',' potentialvalue ')'		                                                                              {}
			  				|  SCALE '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'		                                                            {}
			  				|  TRANSLATE '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'		                                                        {}
			  				|  CLIP '(' potentialvalue ',' potentialvalue ')'		                                                                                {}
			  				|  RANDOM '(' potentialvalue ',' potentialvalue ')'		                                                                              {$$=(new ComplexNode())->binop($3,$5,"random");delete $3;$3=nullptr;delete $5;$5=nullptr;}
			  				|  EXP '(' potentialvalue ',' potentialvalue ')'		                                                                                {}
			  				|  potentialvalue '+' potentialvalue																																																{$$=(new ComplexNode())->binop($1,$3,"add");delete $1;$1=nullptr;delete $3;$3=nullptr;}
								|  potentialvalue '-' potentialvalue																																																{$$=(new ComplexNode())->binop($1,$3,"sub");delete $1;$1=nullptr;delete $3;$3=nullptr;}
								|  potentialvalue '*' potentialvalue																																																{$$=(new ComplexNode())->binop($1,$3,"mul");delete $1;$1=nullptr;delete $3;$3=nullptr;}
								|  potentialvalue '/' potentialvalue																																																{$$=(new ComplexNode())->binop($1,$3,"div");delete $1;$1=nullptr;delete $3;$3=nullptr;}
								|  potentialvalue "mod" potentialvalue																																															{$$=(new ComplexNode())->binop($1,$3,"mod");delete $1;$1=nullptr;delete $3;$3=nullptr;}	
								|  '+' potentialvalue				                																																												{$$=new ComplexNode($2);delete $2;$2=nullptr;}
								|  '-' potentialvalue																																																								{$$=(new ComplexNode())->unop($2,"neg");delete $2;$2=nullptr;}
								|  SIN '(' potentialvalue ')'		                                                                                                    {$$=(new ComplexNode())->unop($3,"sin");delete $3;$3=nullptr;}
								|  COS '(' potentialvalue ')'		                                                                                                    {$$=(new ComplexNode())->unop($3,"cos");delete $3;$3=nullptr;}
			  				|  ABS '(' potentialvalue ')'																																																				{$$=(new ComplexNode())->unop($3,"abs");delete $3;$3=nullptr;}
			  				|  LN  '(' potentialvalue ')'																																																				{$$=(new ComplexNode())->unop($3,"ln" );delete $3;$3=nullptr;}
			  				|  "<<" list ">>"																																																										{$$=(new ComplexNode())->pathoverpoints($2);delete $2;$2=nullptr;}
			  				; 
	
/*1*/
potentialvalue  :	 VAL_INT 																	{$$=new ComplexNode($1);delete $1;$1=nullptr;}
								|  VAL_NUM 																	{$$=new ComplexNode($1);delete $1;$1=nullptr;}
				   			|  VAL_STRING 															{$$=new ComplexNode($1);delete $1;$1=nullptr;}
				   			|  IDENTIFIER																{$$=new ComplexNode($1);delete $1;$1=nullptr;}		
				   			|  fcall                 										{$$=new ComplexNode($1);delete $1;$1=nullptr;}	
				   			|  '{' commands '}'													{$$=new ComplexNode($2);delete $2;$2=nullptr;}
				   			|  '(' potentialvalue ')'										{$$=new ComplexNode($2);delete $2;$2=nullptr;}	
				   			|  '(' potentialvalue ',' potentialvalue ')'{$$=(new ComplexNode())->setPoint($2->getCode(),$4->getCode());delete $2;delete $4;$2=nullptr;$4=nullptr;} /* tuple, used for points and describing function */
                ;

list          	:  potentialvalue														{$$=(new ComplexNode())->initList($1);delete $1;$1=nullptr;}
              	|  list ',' potentialvalue									{$$=(new ComplexNode())->expandList($1,$3);delete $1;$1=nullptr;delete $3;$3=nullptr;}
              	;

/*2*/
              
/*3*/

%%

int main(int argc, char* argv[]){
  extern FILE* yyin;
  ++argv;--argc;
  yyin = fopen(argv[0],"r");
  //yydebug = 1;
  yylineno=1;
  yyparse();
  //printf("accepted\n");
}

void yyerror(const char* s){
  printf("rejected: \n");
  printf("Error on line %d, text \"%s\": %s\n", yylineno,yytext, s);
  exit(-1);
}
