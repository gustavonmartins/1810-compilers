#include "ParserHelper.h"
#include "ST.h"
#include "CG.h"
#include <stdlib.h>
#include <stdio.h>

struct lbs* newlblrec(){
  return (struct lbs*) malloc(sizeof(struct lbs));
}

void install(char* sym_name){
  struct symrec* s;
  s=getsym(sym_name);
  if(s==0){
    s=putsym(sym_name);
  }else{
    errors++;
    printf("%s is already defined\n", sym_name);
  }
}

void context_check(enum code_ops operation, char* sym_name){
  struct symrec* identifier;
  identifier=getsym(sym_name);
  if(identifier==0){
    errors++;
    printf("%s",sym_name);
    printf("%s\n"," is an undeclared identifier");
  } else {
    gen_code(operation, identifier->offset);
  }
}

void yyerror(char* s){
  errors++;
  printf("%s\n", s);
}
