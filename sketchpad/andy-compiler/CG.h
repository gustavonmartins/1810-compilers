#include "SM.h"

int data_location();
int gen_label();
int reserve_loc();
void gen_code(enum code_ops operation,int arg);
void back_patch(int addr, enum code_ops operation, int arg);
