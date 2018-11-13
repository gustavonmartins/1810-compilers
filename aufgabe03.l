%{
#include <string.h>
#include <stdlib.h>
#include "aufgabe03.tab.h"
%}

DIGIT [0-9]
ID    [a-zA-Z][a-zA-Z0-9]*
INT   [ ]*{DIGIT}+[ ]*
NUM   [ ]*{DIGIT}+\.{DIGIT}*[ ]*
STRING \".*\"

%option yylineno

%%

setcolor			  {return SETCOLOR;}
setdrawstyle		  {return SETDRAWSTYLE;}
setfont				  {return SETFONT;}
setlinewidth		  {return SETLINEWIDTH;}
arc				 	  {return ARC;}
ellipse			 	  {return ELLIPSE;}
plot				  {return PLOT;}
string2path				{return STRING2PATH;}
concat						{return CONCAT;}
union 				  {return UNION;}
scaletobox 			  {return SCALETOBOX;}
draw				  {return DRAW;}
fill				  {return FILL;}
num2string	 		  {return NUM2STRING;}
write				  {return WRITE;}
rotate				  {return ROTATE;}
scale				  {return SCALE;}
translate			  {return TRANSLATE;}
clip				  {return CLIP;}

sin										{return SIN;}
cos										{return COS;}
random								{return RANDOM;}
exp										{return EXP;}

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
"mod"				  				{return MOD;}
{ID}                  {return IDENTIFIER;}
{NUM}                 {yylval.ast_double=atof(yytext);return VAL_NUM;}
{INT}                 {yylval.ast_int=atoi(yytext); 	return VAL_INT;}


[ \t\r\n]+            {}
\%.*                  {}
.                     {return yytext[0];}
%%                    

int yywrap(void){}
