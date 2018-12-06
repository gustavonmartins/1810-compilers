%{
#include <string.h>
#include <stdlib.h>
#include "aufgabe03.tab.h"

#include "datastructure.h"
#include "globals.hpp"

%}

DIGIT [0-9]
ID    [a-zA-Z][a-zA-Z0-9]*
INT   [ ]*{DIGIT}+[ ]*
NUM   [ ]*{DIGIT}+\.{DIGIT}*[ ]*
STRING \"(\\.|[^\\"])*\"	

%option yylineno
%option noyywrap

%%

setcolor						  {return SETCOLOR;}
setdrawstyle					{return SETDRAWSTYLE;}
setfont							  {return SETFONT;}
setlinewidth					{return SETLINEWIDTH;}
arc				 	  				{return ARC;}
ellipse			 				  {return ELLIPSE;}
plot				  				{return PLOT;}
string2path						{return STRING2PATH;}
concat								{return CONCAT;}
union 							  {return UNION;}
scaletobox 						{return SCALETOBOX;}
draw				  				{return DRAW;}
fill				  				{return FILL;}
num2string	 					{return NUM2STRING;}
write				  				{return WRITE;}
rotate							  {return ROTATE;}
scale				  				{return SCALE;}
translate						  {return TRANSLATE;}
clip				  				{return CLIP;}

sin										{return SIN;}
cos										{return COS;}
random								{return RANDOM;}
exp										{return EXP;}
abs										{return ABS;}
ln                    {return LN;}

picture               {return(PICTURE);}
start                 {return(START);}
end                   {return(END);}
var                   {return(VAR);}

Int                   {yylval.ast_fc=(new ComplexNode())->setType(Type::INT);   return(TYPE);}
Num                   {yylval.ast_fc=(new ComplexNode())->setType(Type::NUM);   return(TYPE);}
String                {yylval.ast_fc=(new ComplexNode())->setType(Type::STRING);return(TYPE);}
Point                 {yylval.ast_fc=(new ComplexNode())->setType(Type::POINT); return(TYPE);}
Path                  {yylval.ast_fc=(new ComplexNode())->setType(Type::PATH);  return(TYPE);}
Term                  {yylval.ast_fc=(new ComplexNode())->setType(Type::TERM);  return(TYPE);}

for                   {return(FOR);}
to                    {return(TO);}
step                  {return(STEP);}
do                    {return(DO);}
done                  {return(DONE);}

":="                  {return ASGN;}
"<-"                  {return ASGN_LATE;}
"<<"                  {return LBLB;}
">>"                  {return RBRB;}

{STRING}              {yylval.ast_fc=(new ComplexNode())->setString(yytext)->setDebugInfo(yylineno);		return VAL_STRING;}
"mod"				  				{return MOD;}
{ID}                  {yylval.ast_fc=(new CN_Identifier())->setCode(yytext)->setDebugInfo(yylineno);		return IDENTIFIER;}
{NUM}                 {yylval.ast_fc=(new ComplexNode())->setNum(yytext)->setDebugInfo(yylineno);		return VAL_NUM;}
{INT}                 {yylval.ast_fc=(new ComplexNode())->setInt(yytext)->setDebugInfo(yylineno);		return VAL_INT;}


[ \t\r\n]+            {}
\%.*                  {}
.                     {return yytext[0];}
%%                    

//int yywrap(void){}
