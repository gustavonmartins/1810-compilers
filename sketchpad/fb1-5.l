%{
#include "fb1-5.tab.h"
%}

%%
"+"       {return ADD;}
"-"       {return SUB;}
"*"       {return MUL;}
"/"       {return DIV;}
"|"       {return ABS;}
"^"       {return POT;}
[0-9]+    {yylval=atoi(yytext);return NUMBER;}
\n        {return EOL;}
"("       {return OP;}
")"       {return CP;}
[ \t]     {}
.         {printf("Mystery character %c\n",*yytext);}
%%

