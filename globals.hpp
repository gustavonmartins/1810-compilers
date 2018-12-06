#include <string>

extern VarStore env;
extern void yyerror(const char *msg);
extern void error_nonblocking(const char* s);
extern void error_nonblocking(const char* s, int lineno, std::string token);
extern int yylex();
extern int yylineno;
extern char *yytext;
