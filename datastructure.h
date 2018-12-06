#ifndef DS_H
#define DS_H
#include <iostream>
#include <vector>
#include <map>

enum class Type {UNSET, INT, NUM, STRING, POINT, PATH, TERM};

class Tree{
  public:
  virtual ~Tree()=default;
  
  void addchild(Tree* child);
  void traversebfs();
  void subtraversebfs();
  
  int lineno;
  std::string token;
  
protected:
  virtual void finalwork()=0;
  Tree* probeifsinglechild();
  
private:
  std::vector<Tree*> children_vector;

};
////////////////////////////////////////////////////////////////////////////////////
class ComplexNode : public Tree
{
    std::vector<ComplexNode> list;
    Type type;
protected:
  std::string code;

  void finalwork() override;
public:  
    virtual ~ComplexNode()=default;  //virtual to support identifiers capabilities
    
    ComplexNode();
    ComplexNode(char* _code);
    ComplexNode(std::string _code);
    ComplexNode(ComplexNode*& child);
    
    ComplexNode* setDebugInfo(int line);
    void checkType(Type shouldtype);
    ComplexNode* printCode();
    void checkTypeOR(Type shouldtype, Type shouldtypeOR);ComplexNode* setPoint(ComplexNode*& x,ComplexNode*& y);
    
    ComplexNode* setString(std::string inp);
    ComplexNode* setNum(char* _code);
    ComplexNode* setInt(char* _code);

    virtual ComplexNode* setType(Type intype);  //virtual to support identifiers capabilities]
    virtual void checkdeclared();
    ComplexNode* setType(ComplexNode*& source);
    virtual Type getType();
    ComplexNode* setCode(std::string _code);
    std::string getCode() const;
    

    ComplexNode* setlinewidth(ComplexNode*& w);
    ComplexNode* arc(ComplexNode*& p, ComplexNode*& r, ComplexNode*& alpha, ComplexNode*& beta);
    ComplexNode* ellipse(ComplexNode*& p, ComplexNode*& r1, ComplexNode*& r2, ComplexNode*& alpha, ComplexNode*& beta);
    ComplexNode* plot(ComplexNode*& x, ComplexNode*& y, ComplexNode*& n, ComplexNode*& min, ComplexNode*& max, ComplexNode*& function);
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
//////////////////////////////////////////////////////////////////
std::string typeToString(Type type);
//////////////////////////////////////////////////////////////////
class CN_Identifier: public ComplexNode{
  
  public:
  ComplexNode* setType(Type intype) override;
  void checkdeclared()  override;
  Type getType() override;
};


//////////////////////////////////////////////////////////////////
class VarStore{
  std::map<std::string, Type> db;

  public:
  void trydeclaring(const ComplexNode* id, Type type);   //should reference to pointer be here?
  void checkdeclared(const ComplexNode* lhs);            //should reference to pointer be here?
  Type getType(ComplexNode* id);                        //should reference to pointer be here?
  void checkcompatible(ComplexNode* lhs, ComplexNode* rhs); //should reference to pointer be here?
};

//////////////////////////////////////////////////////////////////////
class Declaration: public ComplexNode{
  ComplexNode* id;
  Type type;
public:
  Declaration(CN_Identifier*& id, Type type);
  void finalwork() override;
};

///////////////////////////////////////////////////////////////////////////
class ForLoop: public ComplexNode{
  ComplexNode *id, *start, *end, *inc, *cmd;
  //commands not declared here because are inside children (inherited)
public:
  ForLoop(ComplexNode* id, ComplexNode* start, ComplexNode* end, ComplexNode* inc, ComplexNode* cmd);
  void finalwork() override;
};
///////////////////////////////////////////////////////////////////////////
class SetColor: public ComplexNode{
  ComplexNode *r, *g, *b;
public:
  SetColor(ComplexNode*& r,ComplexNode*& g,ComplexNode*& b);
  void finalwork() override;
};

///////////////////////////////////////////////////////////////////////////
class SetDrawStyle: public ComplexNode{
  ComplexNode *s, *e;
public:
  SetDrawStyle(ComplexNode* s, ComplexNode* e);
  void finalwork() override;
};
////////////////////////////////////////////////////////////////////
class SetFont: public ComplexNode{
  ComplexNode *font, *s;

public:
  SetFont(ComplexNode*& font,ComplexNode*& s);
  void finalwork() override;
  
};
////////////////////////////////////////////////////////////////////
class SetLineWidth: public ComplexNode{
  ComplexNode *w;

public:
  SetLineWidth(ComplexNode*& w);
  void finalwork() override;
  
};

#endif
