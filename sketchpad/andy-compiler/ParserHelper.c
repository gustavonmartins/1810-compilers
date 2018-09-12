#include "ParserHelper.h"
#include "ST.h"
#include "CG.h"
#include <stdlib.h>
#include <stdio.h>



void yyerror(char* s){
  errors++;
  printf("%s\n", s);
}
