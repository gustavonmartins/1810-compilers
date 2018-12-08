#include <string>

//extern VarStore env;
extern void yyerror(const char *msg);
extern void error_nonblocking(const char* s);
extern void error_nonblocking(const char* s, int lineno, std::string token);
extern void error_nonblocking(const char* s, int line);
extern int yylex();
extern int yylineno;
extern char *yytext;

extern void setType(ComplexNode* node, Type intype);

extern void try_setType(std::string id, Type intype);
extern int lineno;
