%{
#define YYDEBUG 1

#include <stdlib.h>

extern int yylineno;
extern char *yytext;

#include "datastructure.h"
void yyerror (const char*);
int yylex();

%}

%union {struct Value* ast_value;
  struct PotentialValue* ast_pv;
  struct FCall* ast_fc;
  struct SetColor* ast_setcolor;
}
				
%type <ast_value> VAL_INT VAL_NUM VAL_STRING value
%type <ast_pv> potentialvalue
%type <ast_fc> fcall
%type <ast_setcolor> SETCOLOR

%token PICTURE IDENTIFIER START END
%token VAR
%token TYPE
%token FOR TO VAL_INT STEP DO DONE
%token VAL_NUM VAL_LINESHAPE VAL_STRING
%token FCALLPREFIXOPEN

%token SETCOLOR SETDRAWSTYLE SETFONT SETLINEWIDTH ARC ELLIPSE PLOT STRING2PATH CONCAT UNION SCALETOBOX DRAW FILL NUM2STRING WRITE ROTATE SCALE TRANSLATE CLIP
%token SIN COS RANDOM EXP

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

program 				: PICTURE VAL_STRING declarations START commands END
        				;
	
declarations  	: %empty
              	| declarations declaration 
              	;
	
declaration   	: VAR list ':' TYPE ';'
              	;
	
commands      	: %empty
              	| commands command
              	;
	
command       	:  assign ';' /*1*/
              	|  fcall ';'  /*1*/
              	|  loop ';'   /*1*/
              	|  IDENTIFIER ';'  /* for Terms */
              	;
/*0*/	
assign        	:  IDENTIFIER ":=" potentialvalue   /*2*/
              	|  IDENTIFIER "<-" potentialvalue  /*2*/
              	;
	
fcall         	:  fcall_nonprefix                    																																															{}
			  				|  SETCOLOR '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'							                                              {$$->addFunc($1);}
			  				|  SETDRAWSTYLE '(' potentialvalue ',' potentialvalue ')'             							                                                {}
			  				|  SETFONT '(' potentialvalue ',' potentialvalue ')'		                                                                            {}
			  				|  SETLINEWIDTH '(' potentialvalue ')'		                                                                                          {}
			  				|  ARC '(' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ')'  		                                        {}
			  				|  ELLIPSE '(' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ')'  		                  {}
			  				|  PLOT '(' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ')'		    {}
			  				|  STRING2PATH '(' potentialvalue ',' potentialvalue ')'		                                                                        {}
			  				|  CONCAT '(' potentialvalue ',' potentialvalue ')'		                                                                              {}
			  				|  UNION '(' potentialvalue ',' potentialvalue ')'		                                                                              {}
			  				|  SCALETOBOX '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'		                                                      {}
			  				|  DRAW '(' potentialvalue ')'		                                                                                                  {}
			  				|  FILL '(' potentialvalue ')'		                                                                                                  {}
			  				|  NUM2STRING '(' potentialvalue ')'		                                                                                            {}
			  				|  WRITE '(' potentialvalue ')'		                                                                                                  {}
			  				|  WRITE '(' potentialvalue ',' potentialvalue ')'		                                                                              {}
			  				|  ROTATE '(' potentialvalue ',' potentialvalue ')'		                                                                              {}
			  				|  SCALE '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'		                                                            {}
			  				|  TRANSLATE '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'		                                                        {}
			  				|  CLIP '(' potentialvalue ',' potentialvalue ')'		                                                                                {}
			  				|  SIN '(' potentialvalue ')'		                                                                                                    {}
			  				|  COS '(' potentialvalue ')'		                                                                                                    {}
			  				|  RANDOM '(' potentialvalue ',' potentialvalue ')'		                                                                              {}
			  				|  EXP '(' potentialvalue ',' potentialvalue ')'		                                                                                {}
			  				; 
	
loop          	:  FOR IDENTIFIER ":=" potentialvalue TO potentialvalue STEP potentialvalue DO commands DONE
/*1*/
potentialvalue  :  value           			{$$=(new PotentialValue)->setInt($1->getInt());					std::cout<<"pv: "<<$$->getInt()<<"\n";
																				 $$=(new PotentialValue)->setDouble($1->getDouble());					std::cout<<"pv: "<<$$->getDouble()<<"\n";
																				 $$=(new PotentialValue)->setString($1->getString());					std::cout<<"pv: "<<$$->getString()<<"\n";
																				}		/*3*/
				   			|  IDENTIFIER																{}		
				   			|  fcall                 										{}	
				   			|  "<<" list ">>"														{}
				   			|  '{' commands '}'													{}
				   			|  '(' potentialvalue ')'										{}	
				   			|  '(' potentialvalue ',' potentialvalue ')'{} /* tuple, used for points and describing function */
                   ;

list          	:  potentialvalue
              	|  list ',' potentialvalue
              	;

fcall_nonprefix :  potentialvalue '+' potentialvalue
								|  potentialvalue '-' potentialvalue
								|  potentialvalue '*' potentialvalue
								|  potentialvalue '/' potentialvalue
								|  potentialvalue "mod" potentialvalue
								|  '+' potentialvalue
								|  '-' potentialvalue
								;
/*2*/
              
/*3*/

value           :  VAL_INT 			{$$=(new Value)->setInt($1->getInt());					std::cout<<"v: "<<$$->getInt()<<"\n";}
                |  VAL_NUM 			{$$=(new Value())->setDouble($1->getDouble());	std::cout<<"v: "<<$$->getDouble()<<"\n";}
                |  VAL_STRING 	{$$=(new Value())->setString($1->getString());	std::cout<<"v: "<<$$->getString()<<"\n";}
                ;

%%

int main(int argc, char* argv[]){
  extern FILE* yyin;
  ++argv;--argc;
  yyin = fopen(argv[0],"r");
  //yydebug = 1;
  yylineno=1;
  yyparse();
  printf("accepted\n");

}

void yyerror(const char* s){
  printf("rejected: \n");
  printf("Error on line %d, text \"%s\": %s\n", yylineno,yytext, s);
  exit(-1);
}
