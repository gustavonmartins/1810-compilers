#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "ST.h"
#include "CG.h"

struct symrec{
  char* name;
  int offset;
  struct symrec* next;
};

struct symrec* identifier;
struct symrec* sym_table;

struct lbs* newlblrec(){
  return (struct lbs*) malloc(sizeof(struct lbs));
}

struct symrec* putsym(char* sym_name){
  struct symrec* ptr;
  ptr=(struct symrec*) malloc(sizeof(struct symrec));
  ptr->name=(char*) malloc(strlen(sym_name)+1);
  strcpy(ptr->name, sym_name);
  ptr->offset=data_location();
  ptr->next=(struct symrec*) sym_table;
  sym_table=ptr;
  return ptr;
}

struct symrec* getsym(char* sym_name){
  struct symrec* ptr;
  for(ptr=sym_table;ptr!=(struct symrec*) 0;ptr=(struct symrec*)ptr->next){
    if(strcmp(ptr->name, sym_name)==0){return ptr;}
  }
  return 0;
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
