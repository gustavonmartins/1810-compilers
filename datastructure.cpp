#include "datastructure.h"
#include "globals.hpp"

#include <iostream>
#include <vector>


ComplexNode::ComplexNode()=default;
ComplexNode::ComplexNode(char* _code):type(Type::UNSET){code.assign(_code);}
ComplexNode::ComplexNode(std::string _code):type(Type::UNSET){code=_code;}
ComplexNode::ComplexNode(ComplexNode*& child):type(Type::UNSET){code=child->getCode();}

ComplexNode* ComplexNode::setDebugInfo(int line){lineno=line;return this;}
ComplexNode* ComplexNode::printCode(){std::cout<<" "<<code;return this;}
void ComplexNode::finalwork()
{
  printCode();
}

ComplexNode* ComplexNode::setPoint(ComplexNode*& x,ComplexNode*& y)
{
	x->checkTypeOR(Type::NUM, Type::INT);
	y->checkTypeOR(Type::NUM, Type::INT);

	code=x->getCode()+" "+y->getCode();
	
	setType(Type::POINT);
	
	return this;
}

ComplexNode* ComplexNode::setNum(char* _code){
  code.assign(_code);
  setType(Type::NUM);
  return this;
}

ComplexNode* ComplexNode::setInt(char* _code){
  code.assign(_code);
  setType(Type::INT);
  return this;
}

ComplexNode* ComplexNode::setString(std::string inp){
  code = "("+inp.substr(1, inp.size() - 2)+")";
  setType(Type::STRING);
  return this;
}

ComplexNode* 	ComplexNode::setType(Type intype){type=intype; return this;}
ComplexNode* 	ComplexNode::setType(ComplexNode*& source){type=source->getType(); return this;}
Type  ComplexNode::getType(){
  //std::cout<<"query basic node type...\n";
  if(type!=Type::UNSET){
    return type;
  }
  else{
   return (dynamic_cast<ComplexNode*>(probeifsinglechild()))->getType(); 
  }
}

void ComplexNode::checkType(Type shouldtype)
{
    checkdeclared();
    std::string should, is, msg;
    if(shouldtype!=getType())
    {
        should=typeToString(shouldtype);
        is=typeToString(getType());

        msg="Type mismatch. Type should be "+should+", but is "+is;
        error_nonblocking(msg.c_str(),this->lineno,this->token);
    }

}

void ComplexNode::checkTypeOR(Type shouldtype, Type shouldtypeOR)
{
    std::string should, shouldOR, is, msg;
    if(shouldtype!=getType() && shouldtypeOR!=getType())
    {
        should=typeToString(shouldtype);
        shouldOR=typeToString(shouldtypeOR);
        is=typeToString(getType());

        msg="Type mismatch. Type should be "+should+" or "+shouldOR+", but is "+is;
        error_nonblocking(msg.c_str(), this->lineno,this->token);
    }
}

ComplexNode* ComplexNode::setCode(std::string _code)
{
    code=_code;
    return this;
}
std::string ComplexNode::getCode() const
{
    return code;
}

ComplexNode* ComplexNode::setlinewidth(ComplexNode*& w)
{
		w->checkTypeOR(Type::INT,Type::NUM);
	
    std::string a1, a2, a3, a4, a5, a6;
    
    a1=w->getCode();
    code=a1+" setlinewidth";

    return this;
}

ComplexNode* ComplexNode::arc(ComplexNode*& p, ComplexNode*& r, ComplexNode*& alpha, ComplexNode*& beta)
{
		p			->checkType(Type::POINT);
		r     ->checkTypeOR(Type::INT,Type::NUM);
		alpha ->checkTypeOR(Type::INT,Type::NUM);
		beta	->checkTypeOR(Type::INT,Type::NUM);
		
    std::string a1, a2, a3, a4, a5, a6;
    std::string xy;
    xy=p->getCode();

    a3=r->getCode();
    a4=alpha->getCode();
    a5=beta->getCode();
    code="newpath "+xy+" "+a3+" "+a4+" "+a5+" arc";
    
    setType(Type::PATH);

    return this;
}

ComplexNode* ComplexNode::ellipse(ComplexNode*& p, ComplexNode*& r1, ComplexNode*& r2, ComplexNode*& alpha, ComplexNode*& beta)
{
		p     ->checkType(Type::POINT);
		r1    ->checkTypeOR(Type::INT,Type::NUM);
		r2    ->checkTypeOR(Type::INT,Type::NUM);
		alpha ->checkTypeOR(Type::INT,Type::NUM);
		beta	->checkTypeOR(Type::INT,Type::NUM);
		
    std::string a1, a2, a3, a4, a5, a6;
    std::string xy;
    xy=p->getCode();

    a3=r1->getCode();
    a4=r2->getCode();
    a5=alpha->getCode();
    a6=beta->getCode();
    code="newpath /savematrix matrix currentmatrix def "+xy+" translate "+a3+" "+a4+" scale 0 0 1 "+a5+" "+a6+" arc savematrix setmatrix"; //TODO: have to undo the translate here
    
    setType(Type::PATH);
    
    return this;
}

ComplexNode* ComplexNode::plot(ComplexNode*& x, ComplexNode*& y, ComplexNode*& n, ComplexNode*& min, ComplexNode*& max, ComplexNode*& function){
  x->checkTypeOR(Type::INT,Type::NUM);
  y->checkTypeOR(Type::INT,Type::NUM);
  n->checkTypeOR(Type::INT,Type::NUM);
  min->checkTypeOR(Type::INT,Type::NUM);
  max->checkTypeOR(Type::INT,Type::NUM);
  function->checkType(Type::POINT);
  std::string a1, a2, a3, a4, a5, a6;
  
  setType(Type::PATH);
  
  return this;
}


ComplexNode* ComplexNode::string2path(ComplexNode*& p, ComplexNode*& s)
{
    p->checkType(Type::POINT);
    s->checkType(Type::STRING);
    
    std::string a1, a2, a3, a4, a5, a6;
    std::string xy;
    
    xy=p->getCode();
    a3=s->getCode();

    code="newpath "+xy+" moveto "+a3+" true charpath";
    
    setType(Type::PATH);

    return this;
}

ComplexNode* ComplexNode::write(ComplexNode*& p, ComplexNode*& s)
{
    p->checkType(Type::POINT);
    s->checkType(Type::STRING);
    
    std::string a1, a2, a3, a4, a5, a6;
    std::string xy;
    xy=p->getCode();
    a3=s->getCode();

    code="newpath "+xy+" moveto "+a3+" show";

    return this;
}

ComplexNode* ComplexNode::write(ComplexNode*& s)
{
    s->checkType(Type::STRING);
    
    std::string a1, a2, a3, a4, a5, a6;
    a1=s->getCode();

    code=a1+" show";

    return this;
}

ComplexNode* ComplexNode::num2string(ComplexNode*& n)
{
		n->checkTypeOR(Type::INT,Type::NUM);
		
    std::string a1, a2, a3, a4, a5, a6;
    a1=n->getCode();

    code=a1+" 20 string cvs";
    
    setType(Type::STRING);

    return this;
}

ComplexNode* ComplexNode::draw(ComplexNode*& p)
{
		p->checkType(Type::PATH);
	
    std::string a1, a2, a3, a4, a5, a6;
    
    a1=p->getCode();
    //std::cout<<"test: "<<a1<<std::endl;
    code=a1+" stroke";
    
    setType(Type::TERM);

    return this;
}

ComplexNode* ComplexNode::fill(ComplexNode*& p)
{
    p->checkType(Type::PATH);
    
    std::string a1, a2, a3, a4, a5, a6;
    
    a1=p->getCode();
    code=a1+" closepath fill";
    
    setType(Type::TERM);

    return this;
}
ComplexNode* ComplexNode::bind_valins(ComplexNode*& lhs, ComplexNode*& rhs)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    env.checkcompatible(lhs, rhs);
    a1=lhs->getCode();
    a2=rhs->getCode();

    code="/"+a1+" "+a2+" def";

    return this;
}

ComplexNode* ComplexNode::bind_ident_early(ComplexNode*& lhs, ComplexNode*& rhs)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    env.checkcompatible(lhs, rhs);
    a1=lhs->getCode();
    a2=rhs->getCode();

    code="/"+a1+" //"+a2+" def";

    return this;
}

ComplexNode* ComplexNode::bind_ident_late(ComplexNode*& lhs, ComplexNode*& rhs)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    env.checkcompatible(lhs, rhs);
    a1=lhs->getCode();
    a2=rhs->getCode();

    code="/"+a1+" {"+a2+"} def";

    return this;
}

ComplexNode* ComplexNode::latebinding(ComplexNode*& lhs, ComplexNode*& rhs)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    env.checkcompatible(lhs, rhs);
    a1=lhs->getCode();
    a2=rhs->getCode();

    code="/"+a1+" { "+a2+" } def";

    return this;
}

ComplexNode* ComplexNode::earlybinding(ComplexNode*& lhs, ComplexNode*& rhs)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    env.checkcompatible(lhs, rhs);
    a1=lhs->getCode();
    a2=rhs->getCode();

    code="/"+a1+" { "+a2+" } bind def";

    return this;
}

ComplexNode* ComplexNode::binop(ComplexNode*& left, ComplexNode*& right, std::string op)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    if ("mod"!=op){
      left->checkTypeOR(Type::INT, Type::NUM);
    } else{
      left->checkType(Type::INT);
      right->checkType(Type::INT);
    }
    env.checkcompatible(left,right);
    a1=left->getCode();
    a2=right->getCode();

    if ("random"!=op)
    {
        code=a1+" "+a2+" "+op;
    }
    else
    {
        code="rand 2 31 exp 1 sub div cvr "+a2+" "+a1+" sub cvr mul cvr "+a1+" add cvr";
    }


    return this;
}

ComplexNode* ComplexNode::unop(ComplexNode*& left, std::string op)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    left->checkTypeOR(Type::INT, Type::NUM);
    a1=left->getCode();

    code=a1+" "+op;

    return this;
}

ComplexNode* ComplexNode::forloop(ComplexNode*& id, ComplexNode*& start, ComplexNode*& end, ComplexNode*& inc, ComplexNode*& cmd)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    env.trydeclaring(id, Type::NUM);
    id->checkdeclared();
    id->checkTypeOR(Type::NUM, Type::INT);
    start->checkTypeOR(Type::NUM, Type::INT);
    start->checkdeclared();
    end->checkTypeOR(Type::NUM, Type::INT);
    end->checkdeclared();
    inc->checkTypeOR(Type::NUM, Type::INT);
    inc->checkdeclared();
    //cmd->checkType(Type::TERM);
    a1=id->getCode();
    a2=start->getCode();
    a3=end->getCode();
    a4=inc->getCode();
    a5=cmd->getCode();
    code=a2+" "+a4+" "+a3+" { /"+a1+" exch def "+a5+" } for";

    return this;
}

ComplexNode* ComplexNode::append(ComplexNode*& extra)
{
    code=code+"\n"+extra->getCode();

    return this;
}

ComplexNode* ComplexNode::pathoverpoints(ComplexNode*& rawlist)
{
    std::vector<ComplexNode> listcopy=rawlist->getList();
    std::string xy;

    for (std::vector<ComplexNode>::iterator it = listcopy.begin(); it!=listcopy.end(); ++it)
    {
				it->checkType(Type::POINT);
				
        xy=it->getCode();
        if(it==listcopy.begin())
        {
            code="newpath "+xy+" moveto ";
        }
        else
        {
            code=code+" "+xy+" lineto";
        }
    }

		setType(Type::PATH);

    return this;
}

ComplexNode* ComplexNode::initList(ComplexNode*& element)
{
    list.push_back(*element);
    return this;
}

ComplexNode* ComplexNode::expandList(ComplexNode*& baselist, ComplexNode*& element)
{
    list=baselist->getList();
    list.push_back(*element);

    return this;
}
std::vector<ComplexNode> ComplexNode::getList()
{
    return list;
}

ComplexNode* ComplexNode::translate(ComplexNode*& x, ComplexNode*& y, ComplexNode*& term)
{
		x->checkTypeOR(Type::INT,Type::NUM);
		y->checkTypeOR(Type::INT,Type::NUM);
		term->checkType(Type::TERM);
		
    std::string a1,dummy, a2, a3, a4, a5, a6;
    a1=x->getCode();
    a2=y->getCode();
    a3=term->getCode();

    code=a1+" "+a2+" translate "+a3+" "+a1+" neg "+a2+" neg translate" ;
    
    setType(Type::TERM);

    return this;
}

ComplexNode* ComplexNode::rotate(ComplexNode*& alpha, ComplexNode*& term)
{
		alpha->checkTypeOR(Type::INT,Type::NUM);
		term->checkType(Type::TERM);
		
    std::string a1,dummy, a2, a3, a4, a5, a6;
    a1=alpha->getCode();
    a2=term->getCode();

    code=a1+"  rotate "+a2+" "+a1+" neg rotate";
    
    setType(Type::TERM);

    return this;
}

ComplexNode* ComplexNode::scale(ComplexNode*& x, ComplexNode*& y, ComplexNode*& term)
{
		x->checkTypeOR(Type::INT,Type::NUM);
		y->checkTypeOR(Type::INT,Type::NUM);
		term->checkType(Type::TERM);
		
    std::string a1,dummy, a2, a3, a4, a5, a6;
    a1=x->getCode();
    a2=y->getCode();
    a3=term->getCode();

    code=a1+" "+a2+" scale "+a3+" 1 "+a1+" div 1 "+a2+" div scale" ;
    
    setType(Type::TERM);

    return this;
}

ComplexNode* ComplexNode::clip(ComplexNode*& p, ComplexNode*& t)
{
		p->checkType(Type::PATH);
		t->checkType(Type::TERM);
		
    std::string cliparea, term;
    cliparea=p->getCode();
    term=t->getCode();
    code="clipsave\n"+cliparea+"\nclip\n"+term+"\ncliprestore";

    return this;
}

void ComplexNode::checkdeclared(){} //Nothing to do, only on identifier class

//////////////////////////////////////////////////////////////////
std::string typeToString(Type type){
	switch(type){
		case Type::INT: return "int";
		case Type::NUM: return "num";
		case Type::STRING: return "string";
		case Type::POINT: return "point";
		case Type::PATH: return "path";
		case Type::TERM: return "term";
		case Type::UNSET: return "unset";
		default: std::cout<<"type to string error\n. Program quits"<<std::endl;exit(-1);
		}
	}
//////////////////////////////////////////////////////////////////
ComplexNode* CN_Identifier::setType(Type intype){
  //std::cout<<"BEGIN CN_ID set type to "<<typeToString(intype)<<std::endl;
  env.trydeclaring(this, intype);
  //std::cout<<"END CN_ID set type to "<<typeToString(intype)<<std::endl;

  return this; 
}

void CN_Identifier::checkdeclared() {
  env.checkdeclared(this);
}

Type CN_Identifier::getType(){
  //std::cout<<">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>querying CN_ID type...\n";
  return env.getType(this);
}
//////////////////////////////////////////////////////////////////
void VarStore::trydeclaring(const ComplexNode* id, Type type){
  auto ret = db.insert(std::make_pair(id->getCode(), type));

  if(ret.second) //the value was sucessfully inserted
  { 
    //std::cout<<"VarStore confirms decl of "<<id->getCode()<<std::endl;
  }
  else //alredy declared
  {
      std::string output="Variable "+id->getCode()+" already declared previously";
      error_nonblocking(output.c_str(),id->lineno,id->getCode());
  }
}

void VarStore::checkdeclared(const ComplexNode* lhs){
  std::map<std::string, Type>::iterator it = db.find(lhs->getCode());
  if(it==db.end()){
    std::string output="Attempted usage of undeclared variable "+lhs->getCode();
    error_nonblocking(output.c_str(), lhs->lineno, lhs->getCode());
  }
}

Type VarStore::getType(ComplexNode* id){
  std::map<std::string, Type>::iterator it = db.find(id->getCode());
  if(it!=db.end()){
    return it->second;
  }
  else{
    std::string output="Many error messages will be generated from here on, all redundant but formulated in different ways, because tried to query a type on undeclared variable "+id->getCode();
    error_nonblocking(output.c_str(),id->lineno,id->getCode());
    return Type::UNSET;
  }
}

void VarStore::checkcompatible(ComplexNode* lhs, ComplexNode* rhs){
  Type lhsType=lhs->getType();
  Type rhsType=rhs->getType();
  if (lhsType==rhsType){return ;}
  else if ((lhsType==Type::NUM)&&(rhsType==Type::INT)){return ;}
  else if ((lhsType==Type::INT)&&(rhsType==Type::NUM)){return ;}
  else{
    std::string output="Type incompability between left ("+typeToString(lhsType)+") and right ("+typeToString(rhsType)+") hand sides";
    error_nonblocking(output.c_str(),lhs->lineno,lhs->getCode());
  }
}
/////////////////////////////////////////////////////////////////////////
void Tree::traversebfs()
{
  subtraversebfs();
  finalwork();
}

void Tree::subtraversebfs()
{
  //std::cout<<"subtransversing on "<<children_vector.size()<<+" elements"<<std::endl;
  for(Tree* current:children_vector){
    current->traversebfs();
  }
}


void Tree::addchild(Tree* child)
{
	if(nullptr!=child){
    children_vector.push_back(child);
    lineno=child->lineno;
  }else{
    std::cout<<"addchild tried adding nullptr"<<std::endl;
    exit(-1);
  }
}

Tree* Tree::probeifsinglechild()
{
  if(children_vector.size()==1){
    return *children_vector.begin();
  }
  else{
    std::cout<<"Error: tried to probe type recursively from vector with more than 1 child";
    exit(-1);
  }
}


/////////////////////////////////////////////////////////////////////////
Declaration::Declaration(CN_Identifier*& id, Type type)
:id(id), type(type){}

void Declaration::finalwork(){
  id->setType(type);
  //std::cout<<"%declared "<<id->getCode()<<std::endl;
}

///////////////////////////////////////////////////////////////////////////
ForLoop::ForLoop(ComplexNode* id, ComplexNode* start, ComplexNode* end, ComplexNode* inc, ComplexNode* cmd)
:id(id), start(start), end(end), inc(inc), cmd(cmd){}

void ForLoop::finalwork(){
  
  id->setType(Type::NUM);
  
  start->checkTypeOR(Type::NUM, Type::INT);
  start->checkdeclared();
  
  end->checkTypeOR(Type::NUM, Type::INT);
  end->checkdeclared();
  
  inc->checkTypeOR(Type::NUM, Type::INT);
  inc->checkdeclared();

  //Goal: start inc end {/id exch def cmd } for
  start->traversebfs();
  inc->traversebfs();
  end->traversebfs();
  std::cout<<" { /";
  id->traversebfs();
  std::cout<<" exch def ";
  cmd->traversebfs(); //Will traverse inside cmd, inherited
  std::cout<<" } for";
}
///////////////////////////////////////////////////////////////////////////
SetColor::SetColor(ComplexNode*& r, ComplexNode*& g, ComplexNode*& b)
:r(r), g(g), b(b){}

void SetColor::finalwork()
{
  r->checkTypeOR(Type::INT,Type::NUM);
  g->checkTypeOR(Type::INT,Type::NUM);
  b->checkTypeOR(Type::INT,Type::NUM);
  
  r->traversebfs();
  g->traversebfs();
  b->traversebfs();
  
  std::cout<<" setrgbcolor\n";
}

///////////////////////////////////////////////////////////
SetDrawStyle::SetDrawStyle(ComplexNode* s, ComplexNode* e)
:s(s), e(e){}

void SetDrawStyle::finalwork()
{
  s->checkType(Type::INT);
  e->checkType(Type::INT);
    
  std::cout<<"[";
  s->traversebfs();
  e->traversebfs();
  std::cout<<"] 0 setdash\n";
}

///////////////////////////////////////////////////////////////////
SetFont::SetFont(ComplexNode*& font, ComplexNode*& s)
:font(font), s(s) {}

void SetFont::finalwork()
{
  font->checkType(Type::STRING);
  s->checkTypeOR(Type::INT, Type::NUM);
  
  //Goal: code="/"+a1+" findfont "+a2+" scalefont setfont";
  std::cout<<"/";
  font->traversebfs();
  std::cout<<" findfont";
  s->traversebfs();
  std::cout<<" scalefont setfont\n";
}