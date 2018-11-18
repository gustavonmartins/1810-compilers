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
%type <ast_fc> command IDENTIFIER

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
              	| commands command											{}
              	;
	
command       	:  IDENTIFIER ":=" potentialvalue  ';'	{}	 /*2*/
              	|  IDENTIFIER "<-" potentialvalue  ';'	{(new ComplexNode())->latebinding($1,$3)->printCode();delete $1;$1=nullptr;delete $3;$3=nullptr;}	/*2*/
              	|  fcall ';'  													{(new ComplexNode($1))->printCode();										delete $1;$1=nullptr;											} /*1*/
              	|  loop ';'   													{} /*1*/
              	|  IDENTIFIER ';' 											{(new ComplexNode($1))->printCode();} /* for Terms */
              	;
	
fcall         	:  fcall_nonprefix                    																																															{}
			  				|  SETCOLOR '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'							                                              {$1=(new ComplexNode())->setcolor($3,$5,$7);				$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  SETDRAWSTYLE '(' potentialvalue ',' potentialvalue ')'             							                                                {$1=(new ComplexNode())->setdrawstyle($3,$5);				$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  SETFONT '(' potentialvalue ',' potentialvalue ')'		                                                                            {$1=(new ComplexNode())->setfont($3,$5);						$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  SETLINEWIDTH '(' potentialvalue ')'		                                                                                          {$1=(new ComplexNode())->setlinewidth($3);					$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  ARC '(' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ')'  		                                        {$1=(new ComplexNode())->arc($3,$5,$7,$9);					$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  ELLIPSE '(' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ')'  		                  {$1=(new ComplexNode())->ellipse($3,$5,$7,$9,$11);	$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  PLOT '(' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ')'		    {std::cout<<"not to be implemented"<<std::flush;																													 }                                 
			  				|  STRING2PATH '(' potentialvalue ',' potentialvalue ')'		                                                                        {$1=(new ComplexNode())->string2path($3,$5);				$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  CONCAT '(' potentialvalue ',' potentialvalue ')'		                                                                              {std::cout<<"not to be implemented"<<std::flush;																													 }         
			  				|  UNION '(' potentialvalue ',' potentialvalue ')'		                                                                              {std::cout<<"not to be implemented"<<std::flush;																													 }         
			  				|  SCALETOBOX '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'		                                                      {std::cout<<"not to be implemented"<<std::flush;																													 }         
			  				|  DRAW '(' potentialvalue ')'		                                                                                                  {$1=(new ComplexNode())->draw($3);									$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
			  				|  FILL '(' potentialvalue ')'		                                                                                                  {$1=(new ComplexNode())->fill($3);									$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
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
potentialvalue  :	 VAL_INT 																	{$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
								|  VAL_NUM 																	{$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
				   			|  VAL_STRING 															{$$=new ComplexNode($1->getCode());delete $1;$1=nullptr;}
				   			|  IDENTIFIER																{}		
				   			|  fcall                 										{}	
				   			|  "<<" list ">>"														{}
				   			|  '{' commands '}'													{}
				   			|  '(' potentialvalue ')'										{}	
				   			|  '(' potentialvalue ',' potentialvalue ')'{$$=(new ComplexNode())->setPoint($2->getCode(),$4->getCode());delete $2;delete $4;$2=nullptr;$4=nullptr;} /* tuple, used for points and describing function */
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
