%{
#include <string.h>
#include <stdlib.h>
#include "aufgabe03.tab.h"
%}

DIGIT [0-9]
ID    [a-zA-Z][a-zA-Z0-9]*
INT   [ ]*[~]?{DIGIT}+[ ]*
NUM   [ ]*[~]?{DIGIT}+\.?{DIGIT}*[ ]*
FCALLPREFIXOPEN {ID}[ ]*"("
POINT "("{NUM}","{NUM}")"
STRING \".*\"

%option yylineno

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
"mod"				  {return MOD;}
{FCALLPREFIXOPEN}     {return FCALLPREFIXOPEN;}
{POINT}               {return VAL_POINT;}
{ID}                  {return IDENTIFIER;}
{NUM}                 {return VAL_NUM;}
{INT}                 {return VAL_INT;}


[ \t\r\n]+              {}
\%.*                  {}
.                     {return yytext[0];}
%%                    

int yywrap(void){}
