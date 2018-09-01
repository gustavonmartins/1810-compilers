%{
#include <stdio.h>
#include <math.h>
%}

%token EOL SUB ADD MUL DIV ABS NUMBER OP CP POT

%%
calclist  : %empty
          | calclist exp EOL    {printf("= %d\n",$2);}
          ;

exp       : exp SUB factor      {$$ = $1 - $3;}
          | exp ADD factor      {$$ = $1 + $3;}
          | factor
          ;

factor    : factor MUL pow    {$$ = $1 * $3;}
          | factor DIV pow     {$$ = $1 / $3;}
          | pow
          ;

pow       : pow POT term        {$$ = pow($1,$3);}
          | term
          ;

term      : NUMBER
          | ABS term            {$$ = $2 > 0? $2 : -$2;}
          | OP exp CP           {$$ = $2;}
          ;

%%
void main(){
  yyparse();
}

void yyerror(char* s){
  fprintf(stderr,"error: %s\n",s);
}
