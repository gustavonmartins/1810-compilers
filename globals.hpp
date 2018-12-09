#ifndef GLOBALS_HPP
#define GLOBALS_HPP
#include<string>

extern VarStore env;
extern void yyerror(const char *msg);
extern void error_nonblocking(const char* s);
extern int yylex();
extern int yylineno;
extern char *yytext;
extern const std::string disable_newpath;
extern const std::string reenable_newpath;

#endif
