#ifndef ST_H
#define ST_H

struct symrec{
  char* name;
  int offset;
  struct symrec* next;
};

struct symrec* identifier;
struct symrec* sym_table;
struct symrec* putsym(char* sym_name);
struct symrec* getsym(char* sym_name);

#endif
