%{
#define YYDEBUG 1

#include <stdlib.h>

extern int yylineno;
extern char *yytext;

%}

%token PICTURE IDENTIFIER START END
%token VAR
%token TYPE
%token FOR TO VAL_INT STEP DO DONE
%token VAL_NUM VAL_LINESHAPE VAL_STRING
%token FCALLPREFIXOPEN

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

program : PICTURE VAL_STRING declarations START commands END
        ;

declarations  : %empty
              | declarations declaration 
              ;

declaration   : VAR list ':' TYPE ';'
              ;

commands      : %empty
              | commands command
              ;

command       :  assign ';' /*1*/
              |  fcall ';'  /*1*/
              |  loop ';'   /*1*/
              |  IDENTIFIER ';'  /* for Terms */
              ;
/*0*/
assign        :  IDENTIFIER ":=" potentialvalue   /*2*/
              |  IDENTIFIER "<-" potentialvalue  /*2*/
              ;

fcall         :  FCALLPREFIXOPEN list ')'                 /*2*/
              |  fcall_nonprefix                      /*2*/
			  ; 

loop          :  FOR IDENTIFIER ":=" potentialvalue TO potentialvalue STEP potentialvalue DO commands DONE
/*1*/
potentialvalue     :  value           				/*3*/
				   |  IDENTIFIER
				   |  fcall                       /*3 (in 2)*/
				   |  "<<" list ">>"
				   |  '{' commands '}'
				   |  '(' potentialvalue ')'
                   ;

list          :  potentialvalue
              |  list ',' potentialvalue
              ;

fcall_nonprefix   	:  potentialvalue '+' potentialvalue
					|  potentialvalue '-' potentialvalue
					|  potentialvalue '*' potentialvalue
					|  potentialvalue '/' potentialvalue
					|  potentialvalue "mod" potentialvalue
					|  '+' potentialvalue
					|  '-' potentialvalue
					;
/*2*/
              
/*3*/

value                 :  '(' potentialvalue ',' potentialvalue ')' /* tuple, used for points and describing function */
                      |  VAL_INT
                      |  VAL_NUM
                      |  VAL_STRING
                      ;

%%

int main(int argc, char* argv[]){
  extern FILE* yyin;
  ++argv;--argc;
  yyin = fopen(argv[0],"r");
  yydebug = 1;
  yylineno=1;
  yyparse();
  printf("accepted\n");

}

void yyerror(const char* s){
  printf("rejected: \n");
  printf("Error on line %d, text \"%s\": %s\n", yylineno,yytext, s);
  exit(-1);
}
