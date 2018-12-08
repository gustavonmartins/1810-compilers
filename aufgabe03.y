%{
#define YYDEBUG 1

#include <stdlib.h>

#include "datastructure.h"
#include "globals.hpp"

%}

%union {
  class ComplexNode* ast_fc;
  class CN_Identifier* ast_identifier;
}
				
%type <ast_fc> VAL_INT VAL_NUM VAL_STRING list potentialvalue fcall command commands program val_ins binding potval_1 potval_2 TYPE declaration declarations
%type <ast_identifier> IDENTIFIER

%token PICTURE IDENTIFIER START END
%token VAR
%token TYPE
%token FOR TO VAL_INT STEP DO DONE
%token VAL_NUM VAL_STRING

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

program         : PICTURE VAL_STRING declarations START commands END  {$3->traversebfs();$5->traversebfs();std::cout<<"\nshowpage\n";}
                ;

declarations  	: %empty                               {$$=(new ComplexNode());}
              	| declarations declaration             {$$=(new ComplexNode());$$->addchild($1);$$->addchild($2);}
              	;

declaration   	: VAR IDENTIFIER ':' TYPE ';'          {$$=new Declaration($2,$4->getType());}
              	;

commands      	: %empty																{$$=new ComplexNode();}
              	| commands command											{$$=(new ComplexNode());$$->addchild($1);$$->addchild($2);}
              	;

command       	:  binding																																												{} /*1*/
              	|  fcall ';'  	                                                                                  {$$=new ComplexNode();$$->addchild($1);} /*1*/
              	|  FOR IDENTIFIER ":=" potentialvalue TO potentialvalue STEP potentialvalue DO commands DONE ';'  {$$=new ComplexNode();$$->addchild(new ForLoop($2, $4, $6, $8, $10));} /*1*/
              	|  IDENTIFIER ';' 																																								{} /* for Terms */
              	;
              	
binding         :  IDENTIFIER ":=" val_ins        ';'                                                               {}   /*2*/
                |  IDENTIFIER "<-" val_ins     		';'																																{}	/*2*/
                |  IDENTIFIER ":=" IDENTIFIER    	';'																																{}
                |  IDENTIFIER "<-" IDENTIFIER    	';'																																{}
                |  IDENTIFIER ":=" potval_2			  ';'    																														{}	 /*2*/
                |  IDENTIFIER "<-" potval_2			  ';'    																														{}	/*2*/
	
fcall           :  SETCOLOR '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'							                                              {$$=new ComplexNode();$$->addchild(new SetColor($3,$5,$7));}
                |  SETDRAWSTYLE '(' potentialvalue ',' potentialvalue ')'             							                                                {$$=new ComplexNode();$$->addchild(new SetDrawStyle($3,$5));}
                |  SETFONT '(' potentialvalue ',' potentialvalue ')'                                                                                {$$=new ComplexNode();$$->addchild(new SetFont($3,$5));}
                |  SETLINEWIDTH '(' potentialvalue ')'                                                                                              {$$=new ComplexNode();$$->addchild(new SetLineWidth($3));}
                |  ARC '(' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ')'  		                                        {}
                |  ELLIPSE '(' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ')'  		                  {}
                |  PLOT '(' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ',' potentialvalue ')'		    {}
                |  STRING2PATH '(' potentialvalue ',' potentialvalue ')'		                                                                        {}
                |  CONCAT '(' potentialvalue ',' potentialvalue ')'		                                                                              {std::cout<<"error: not to be implemented\n"<<std::flush;exit(-1);																													 }         
                |  UNION '(' potentialvalue ',' potentialvalue ')'		                                                                              {std::cout<<"error: not to be implemented\n"<<std::flush;exit(-1);																													 }         
                |  SCALETOBOX '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'		                                                      {std::cout<<"error: not to be implemented\n"<<std::flush;exit(-1);																													 }         
                |  DRAW '(' potentialvalue ')'		                                                                                                  {}
                |  FILL '(' potentialvalue ')'		                                                                                                  {}
                |  NUM2STRING '(' potentialvalue ')'		                                                                                            {}
                |  WRITE '(' potentialvalue ')'		                                                                                                  {}
                |  WRITE '(' potentialvalue ',' potentialvalue ')'		                                                                              {}
                |  ROTATE '(' potentialvalue ',' potentialvalue ')'		                                                                              {}
                |  SCALE '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'		                                                            {}
                |  TRANSLATE '(' potentialvalue ',' potentialvalue ',' potentialvalue ')'		                                                        {}
                |  CLIP '(' potentialvalue ',' potentialvalue ')'		                                                                                {}
                |  RANDOM '(' potentialvalue ',' potentialvalue ')'		                                                                              {}
                |  EXP '(' potentialvalue ',' potentialvalue ')'		                                                                                {}
                |  potentialvalue '+' potentialvalue																																																{}
                |  potentialvalue '-' potentialvalue																																																{}
                |  potentialvalue '*' potentialvalue																																																{}
                |  potentialvalue '/' potentialvalue																																																{}
                |  potentialvalue "mod" potentialvalue																																															{}
                |  '+' potentialvalue				                																																												{}
                |  '-' potentialvalue																																																								{}
                |  SIN '(' potentialvalue ')'		                                                                                                    {}
                |  COS '(' potentialvalue ')'		                                                                                                    {}
                |  ABS '(' potentialvalue ')'																																																				{}
                |  LN  '(' potentialvalue ')'																																																				{}
                ; 
	
/*1*/
potentialvalue  :  potval_1                                 {$$=new ComplexNode();$$->addchild($1);}
								|  potval_2                                 {}
								;
potval_2				:  fcall                 										{}	
				   			|  '{' commands '}' 												{}	/*2*/
				   			|  '(' potentialvalue ')'										{}	
				   			|  '(' potentialvalue ',' potentialvalue ')'{} /* tuple, used for points and describing function */
				   			|  "<<" list ">>"														{}
                ;
                
potval_1        :  val_ins                                  {$$=new ComplexNode();$$->addchild($1);setType($$,$1->getType());} //potential value minus int, num, string and id. due to ps boundary conditions
                |  IDENTIFIER                               {$$=new ComplexNode();$$->addchild($1);} //WARNING: You want to set types not WHILE parsing (here), but AFTER parsin (at traversebfs)
                
val_ins         :  VAL_INT                                  {$$=new ComplexNode();$$->addchild($1);setType($$,Type::INT);}
                |  VAL_NUM                                  {$$=new ComplexNode();$$->addchild($1);setType($$,Type::NUM);}
                |  VAL_STRING                               {$$=new ComplexNode();$$->addchild($1);setType($$,Type::STRING);}

list            :  potentialvalue														{}
                |  list ',' potentialvalue									{}
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

/*
void error_nonblocking(const char* s){
  printf("Error on line %d, \"%s\"\n", yylineno, s);
}
*/
void error_nonblocking(const char* s, int line, std::string token){
  printf("Error on line %d, near token %s \"%s\"\n", line, token.c_str(), s);
}

void error_nonblocking(const char* s, int line){
  printf("Error on line %d \"%s\"\n", line, s);
}
