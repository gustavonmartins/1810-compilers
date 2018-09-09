#include "SM.h"
#include "CG.h"
#include <stdlib.h>

int main(){
  gen_code(LD_INT,3);
  gen_code(STORE,100);
  
  gen_code(LD_VAR,100);
  gen_code(LD_INT,4);
  gen_code(ADD,0);
  gen_code(STORE,100);
  gen_code(LD_VAR,100);
  gen_code(LD_INT,14);
  gen_code(GT,0);
  gen_code(JMP_TRUE,11);
  gen_code(GOTO,2);

  gen_code(WRITE_INT,0);
  gen_code(HALT,0);

  fetch_execute_cycle();
}
