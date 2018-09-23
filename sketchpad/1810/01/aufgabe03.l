%{
#include <string.h>
#include <stdlib.h>
#include "aufgabe03.tab.h"
%}

DIGIT [0-9]
ID    [a-z][a-z0-9]*
INT   DIGIT+

%%

":="                  {return ASGN;};
"<-"                  {return ASGN_LATE;};
picture               {return(PICTURE);};
start                 {return(START);};
end                   {return(END);};
var                   {return(VAR);};
Int                   {return(TYPE);};
Num                   {return(TYPE);};
String                {return(TYPE);};
Point                 {return(TYPE);};
Path                  {return(TYPE);};
Term                  {return(TYPE);};
for                   {return(FOR);};
to                    {return(TO);};
step                  {return(STEP);};
do                    {return(DO);};
done                  {return(DONE);};
"("{DIGIT}+","{DIGIT}+")"      {return(VAL_POINT);};
{ID}                  {return(IDENTIFIER);};
{DIGIT}+              {return VAL_INTEGER;};

[ \t\n]+              {};
.                     {return yytext[0];}
%%                    

int yywrap(void){}
