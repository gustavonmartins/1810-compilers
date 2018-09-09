#ifndef SM_H
#define SM_H

enum code_ops {HALT,STORE,JMP_FALSE,JMP_TRUE,GOTO,
              DATA,LD_INT,LD_VAR,READ_INT,WRITE_INT,
              LT,EQ,GT,ADD,SUB,MULT,DIV,PWR};

struct instruction {enum code_ops op; int arg;};

struct instruction code[999];

void fetch_execute_cycle();

#endif
