#ifndef DS_H
#define DS_H
#include <iostream>
#include <vector>

enum class Type {INT, NUM, STRING, POINT, PATH, TERM};

class ComplexNode
{
    std::string code;
    std::vector<ComplexNode> list;
    Type type;
    void checkType(Type shouldtype);
    void checkTypeOR(Type shouldtype, Type shouldtypeOR);

public:
    ComplexNode();
    ComplexNode(char* _code);
    ComplexNode(std::string _code);
    ComplexNode(ComplexNode*& child);
    ComplexNode* printCode();
    ComplexNode* setPoint(ComplexNode*& x,ComplexNode*& y);
    ComplexNode* setString(std::string inp);
    ComplexNode* setNum(char* _code);
    ComplexNode* setInt(char* _code);

    ComplexNode* setType(Type intype);
    ComplexNode* setType(ComplexNode*& source);
    Type getType();
    ComplexNode* setCode(std::string _code);
    std::string getCode();
    ComplexNode* setcolor(ComplexNode*& r,ComplexNode*& g,ComplexNode*& b);
    ComplexNode* setfont(ComplexNode*& font,ComplexNode*& s);
    ComplexNode* setlinewidth(ComplexNode*& w);
    ComplexNode* setdrawstyle(ComplexNode*& s, ComplexNode*& e);
    ComplexNode* arc(ComplexNode*& p, ComplexNode*& r, ComplexNode*& alpha, ComplexNode*& beta);
    ComplexNode* ellipse(ComplexNode*& p, ComplexNode*& r1, ComplexNode*& r2, ComplexNode*& alpha, ComplexNode*& beta);
    ComplexNode* string2path(ComplexNode*& p, ComplexNode*& s);
    ComplexNode* write(ComplexNode*& p, ComplexNode*& s);
    ComplexNode* write(ComplexNode*& s);
    ComplexNode* num2string(ComplexNode*& n);
    ComplexNode* draw(ComplexNode*& p);
    ComplexNode* fill(ComplexNode*& p);
    ComplexNode* bind_valins(ComplexNode*& lhs, ComplexNode*& rhs);
    ComplexNode* bind_ident_early(ComplexNode*& lhs, ComplexNode*& rhs);
    ComplexNode* bind_ident_late(ComplexNode*& lhs, ComplexNode*& rhs);
    ComplexNode* latebinding(ComplexNode*& lhs, ComplexNode*& rhs);
    ComplexNode* earlybinding(ComplexNode*& lhs, ComplexNode*& rhs);
    ComplexNode* binop(ComplexNode*& left, ComplexNode*& right, std::string op);
    ComplexNode* unop(ComplexNode*& left, std::string op);
    ComplexNode* forloop(ComplexNode*& id, ComplexNode*& start, ComplexNode*& end, ComplexNode*& inc, ComplexNode*& cmd);
    ComplexNode* append(ComplexNode*& extra);
    ComplexNode* pathoverpoints(ComplexNode*& rawlist);
    ComplexNode* initList(ComplexNode*& element);
    ComplexNode* expandList(ComplexNode*& baselist, ComplexNode*& element);
    std::vector<ComplexNode> getList();
    ComplexNode* translate(ComplexNode*& x, ComplexNode*& y, ComplexNode*& therma);
    ComplexNode* rotate(ComplexNode*& alpha, ComplexNode*& therma);
    ComplexNode* scale(ComplexNode*& x, ComplexNode*& y, ComplexNode*& therma);
    ComplexNode* clip(ComplexNode*& p, ComplexNode*& t);
};

std::string typeToString(Type type);

#endif
