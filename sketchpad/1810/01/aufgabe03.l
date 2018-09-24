%{
#include <string.h>
#include <stdlib.h>
#include "aufgabe03.tab.h"
%}

DIGIT [0-9]
ID    [a-zA-Z][a-zA-Z0-9]*
INT   [-+]?{DIGIT}+
NUM   [-+]?{DIGIT}+\.?{DIGIT}*
POINT [^{ID}]"("{NUM}","{NUM}")"
STRING \".*\"

%%


picture               {return(PICTURE);}
start                 {return(START);}
end                   {return(END);}
var                   {return(VAR);}
Int                   {return(TYPE);}
Num                   {return(TYPE);}
String                {return(TYPE);}
Point                 {return(TYPE);}
Path                  {return(TYPE);}
Term                  {return(TYPE);}
for                   {return(FOR);}
to                    {return(TO);}
step                  {return(STEP);}
do                    {return(DO);}
done                  {return(DONE);}

":="                  {return ASGN;}
"<-"                  {return ASGN_LATE;}
"<<"                  {return LBLB;}
">>"                  {return RBRB;}

{STRING}              {return VAL_STRING;}
{POINT}               {return VAL_POINT;}
{ID}                  {return IDENTIFIER;}
{NUM}                 {return VAL_NUM;}
{INT}                 {return VAL_INT;}


[ \t\n]+              {}
\%.*                  {}
.                     {return yytext[0];}
%%                    

int yywrap(void){}
