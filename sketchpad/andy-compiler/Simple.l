%{
#include <string.h>
#include <stdlib.h>
#include "Simple.tab.h"
%}

DIGIT [0-9]
ID    [a-z][a-z0-9]*

%%

":="                  {return(ASSGNOP);};
{DIGIT}+              {yylval.intval=atoi(yytext);return NUMBER;};
do                    {return(DO);};
else                  {return(ELSE);};
end                   {return(END);};
fi                    {return(FI);};
if                    {return(IF);};
in                    {return(IN);};
integer               {return(INTEGER);};
let                   {return(LET);};
read                  {return(READ);};
skip                  {return(SKIP);};
then                  {return(THEN);};
while                 {return(WHILE);};
write                 {return(WRITE);};
{ID}                  {yylval.id=(char*) strdup(yytext);return(IDENTIFIER);};
[ \t\n]+              {};
.                     {return yytext[0];}
%%                    

int yywrap(void){}
