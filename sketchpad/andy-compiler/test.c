#include "SM.h"
#include <stdlib.h>

int main(){
  code[0].op=LD_INT;code[0].arg=3;
  code[1].op=STORE;code[1].arg=100;
  
  code[2].op=LD_VAR;code[2].arg=100;
  code[3].op=LD_INT;code[3].arg=4;
  code[4].op=ADD;
  code[5].op=STORE;code[5].arg=100;
  code[6].op=LD_VAR;code[6].arg=100;
  code[7].op=LD_INT;code[7].arg=34;
  code[8].op=GT;
  code[9].op=JMP_TRUE;code[9].arg=11;
  code[10].op=GOTO;code[10].arg=2;

  code[11].op=WRITE_INT;
  code[12].op=HALT;

  fetch_execute_cycle();
}
