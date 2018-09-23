%{
#define YYDEBUG 1
%}

%token PICTURE IDENTIFIER START END
%token VAR
%token TYPE
%token FOR TO VAL_INTEGER STEP DO DONE
%token VAL_POINT

%token ASGN ASGN_LATE

%%

program : PICTURE '"' IDENTIFIER '"' declarations START commands END
        ;

declarations  : %empty
              | declarations declaration 
              ;

declaration   : VAR IDENTIFIER ':' TYPE ';'
              ;

commands      : %empty
              | commands command
              ;

command       :  assign ';'
              |  fcall ';'
              |  loop ';'
              ;

loop          :  FOR IDENTIFIER ":=" TO VAL_INTEGER STEP VAL_INTEGER DO commands DONE

assign        :  IDENTIFIER ASGN potentialvalue
              |  IDENTIFIER ASGN_LATE potentialvalue
              ;

val_therme    :  '{' commands '}'
              ;
              
fcall         :  IDENTIFIER args
              |  fcall_arith
              ;              
              
fcall_arith   :  IDENTIFIER_or_val '+' IDENTIFIER_or_val
              |  IDENTIFIER_or_val '-' IDENTIFIER_or_val
              |  IDENTIFIER_or_val '*' IDENTIFIER_or_val
              |  IDENTIFIER_or_val '/' IDENTIFIER_or_val
              |  IDENTIFIER_or_val "mod" IDENTIFIER_or_val
              |  "sin" IDENTIFIER_or_val
              |  "cos" IDENTIFIER_or_val
              |  "ln" IDENTIFIER_or_val
              |  "abs" IDENTIFIER_or_val
              |  "random" '(' IDENTIFIER_or_val ',' IDENTIFIER_or_val ')'
              ;

args          :  '(' args_inner ')'
              ;

args_inner    :  potentialvalue
              |  args_inner ',' potentialvalue
              ;
              
IDENTIFIER_or_val     :  IDENTIFIER
                      |  value
                      |  '(' IDENTIFIER_or_val ')'
                      ;

value                 :  VAL_POINT
                      |  VAL_INTEGER
                      ;

potentialvalue     :  IDENTIFIER_or_val
                   |  fcall
                   |  val_therme
                   ;

%%

int main(int argc, char* argv[]){
  extern FILE* yyin;
  ++argv;--argc;
  yyin = fopen(argv[0],"r");
  yydebug = 1;
  yyparse();
  printf("Woow!! Parse Completed!\n");

}

void yyerror(char* s){
  printf("%s\n", s);
}
