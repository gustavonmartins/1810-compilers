%{
#define YYDEBUG 1
%}

%token PICTURE IDENTIFIER START END
%token VAR
%token TYPE
%token FOR TO VAL_INT STEP DO DONE
%token VAL_NUM VAL_POINT VAL_LINESHAPE VAL_STRING

%token ASGN ":=" 
%token ASGN_LATE "<-"
%token LBLB "<<"
%token RBRB ">>"

%%

program : PICTURE VAL_STRING declarations START commands END
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
              |  IDENTIFIER ';'  /* for Terms */
              ;

loop          :  FOR IDENTIFIER ":=" VAL_NUM TO VAL_NUM STEP VAL_NUM DO commands DONE

assign        :  IDENTIFIER ":=" potentialvalue
              |  IDENTIFIER "<-" potentialvalue
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
              |  "sin" '(' IDENTIFIER_or_val ')'  /* TODO: Make it able of calling arithm results*/
              |  "cos" '(' IDENTIFIER_or_val ')'
              |  "ln" '(' IDENTIFIER_or_val ')'
              |  "abs" '(' IDENTIFIER_or_val ')'
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
                      |  "<<" args_inner ">>"
                      ;

value                 :  VAL_POINT
                      |  VAL_INT
                      |  VAL_NUM
                      |  VAL_STRING
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
