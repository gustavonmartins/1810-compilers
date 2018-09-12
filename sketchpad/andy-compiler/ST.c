#include <stdlib.h>
#include <string.h>
#include "ST.h"
#include "CG.h"

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
