%{
#include <stdio.h>
#include <stdlib.h> 
#include <string.h>
#include "ST.h"
#include "SM.h"
#include "CG.h"
#include "ParserHelper.h"
#define YYDEBUG 1

%} 

%union semrec{
  int intval;
  char* id;
  struct lbs* lbls;
} 
%start program
%token LET INTEGER IN
%token SKIP THEN ELSE END DO READ WRITE 
%token <intval> NUMBER
%token <id> IDENTIFIER
%token <lbls> IF WHILE
%token ASSGNOP FI
%left '-' '+'
%left '*' '/'
%right '^'
%%
program     : LET declarations 
                IN                            {gen_code(DATA, data_location()-1);}
                commands 
                END                           {gen_code(HALT, 0);YYACCEPT;}
            ;

declarations: %empty
            | INTEGER id_seq IDENTIFIER '.'   {install($3);}
            ;

id_seq      : %empty
            | id_seq IDENTIFIER ','           {install($2);}
            ;

commands    : %empty
            | commands command ';'
            ;

command     : SKIP
            | READ IDENTIFIER                         {context_check(READ_INT, $2);}
            | WRITE exp                               {gen_code(WRITE_INT,0);}
            | IDENTIFIER ASSGNOP exp                  {context_check(STORE, $1);}
            | IF exp                                  {$1=(struct lbs*) newlblrec();
                                                       $1->for_jmp_false=reserve_loc();
                                                      }
                THEN commands                         {$1->for_goto=reserve_loc();}
                ELSE                                  {back_patch($1->for_jmp_false, JMP_FALSE, gen_label());}
                commands
                FI                                    {back_patch($1->for_goto, GOTO, gen_label());}
            | WHILE                                   {$1 = (struct lbs*) newlblrec();
                                                       $1->for_goto=gen_label();
                                                      }
              exp                                     {$1->for_jmp_false=reserve_loc();}
              DO 
              commands
              END                                     {gen_code(GOTO, $1->for_goto);
                                                      back_patch($1->for_jmp_false, JMP_FALSE, gen_label());}
            ;

exp         : NUMBER                                  {gen_code(LD_INT, $1);}
            | IDENTIFIER                              {context_check(LD_VAR, $1);}
            | exp '<' exp                             {gen_code(LT, 0);} 
            | exp '=' exp                             {gen_code(EQ, 0);} 
            | exp '>' exp                             {gen_code(GT, 0);} 
            | exp '+' exp                             {gen_code(ADD, 0);} 
            | exp '-' exp                             {gen_code(SUB, 0);} 
            | exp '*' exp                             {gen_code(MULT, 0);} 
            | exp '/' exp                             {gen_code(DIV, 0);} 
            | exp '^' exp                             {gen_code(PWR, 0);} 
            | '(' exp ')'
            ;
%%
int main(int argc, char* argv[]){
  extern FILE* yyin;
  ++argv;--argc;
  yyin = fopen(argv[0],"r");
  yydebug = 1;
  errors = 0;
  yyparse();
}
