#ifndef ST_H
#define ST_H

#include "SM.h"

struct lbs{int for_goto, for_jmp_false;};
struct lbs* newlblrec();


void install(char* sym_name);
void context_check(enum code_ops operation, char* sym_name);

int errors;

#endif
