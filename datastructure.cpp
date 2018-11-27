#include "datastructure.h"

#include <iostream>
#include <vector>

extern void yyerror(const char* s);
extern void error_nonblocking(const char* s);



ComplexNode::ComplexNode()=default;
ComplexNode::ComplexNode(char* _code){code.assign(_code);}
ComplexNode::ComplexNode(std::string _code){code=_code;}
ComplexNode::ComplexNode(ComplexNode*& child){code=child->getCode();}
ComplexNode* ComplexNode::printCode(){std::cout<<code<<std::endl;return this;}
ComplexNode* ComplexNode::setPoint(ComplexNode*& x,ComplexNode*& y){code=x->getCode()+" "+y->getCode();return this;}
ComplexNode* ComplexNode::setString(std::string inp){code = "("+inp.substr(1, inp.size() - 2)+")";return this;}

ComplexNode* 	ComplexNode::setType(Type intype){type=intype; return this;}
ComplexNode* 	ComplexNode::setType(ComplexNode*& source){type=source->getType(); return this;}
Type 			ComplexNode::getType(){return type;}

void ComplexNode::checkType(Type shouldtype)
{
    std::string should, is, msg;
    if(shouldtype!=getType())
    {
        should=typeToString(shouldtype);
        is=typeToString(getType());

        msg="Type mismatch. Type should be "+should+", but is "+is;
        error_nonblocking(msg.c_str());
        //std::cout<<"type mismatch: expected "+type+", got "checkee->getType();
        //exit(-1);
    }

}


ComplexNode* ComplexNode::setCode(std::string _code)
{
    code=_code;
    return this;
}
std::string ComplexNode::getCode()
{
    return code;
}
ComplexNode* ComplexNode::setcolor(ComplexNode*& r,ComplexNode*& g,ComplexNode*& b)
{
    std::string a1, a2, a3, a4, a5, a6;
    a1=r->getCode();
    a2=g->getCode();
    a3=b->getCode();
    code=a1+" "+a2+" "+a3+" setrgbcolor";

    return this;
}
ComplexNode* ComplexNode::setfont(ComplexNode*& font,ComplexNode*& s)
{
    std::string a1, a2, a3, a4, a5, a6;
    font->checkType(Type::STRING);
    a1=font->getCode();
    a2 = s->getCode();
    code="/"+a1+" findfont "+a2+" scalefont setfont";

    return this;
}

ComplexNode* ComplexNode::setlinewidth(ComplexNode*& w)
{
    std::string a1, a2, a3, a4, a5, a6;
    a1=w->getCode();
    code=a1+" setlinewidth";

    return this;
}

ComplexNode* ComplexNode::setdrawstyle(ComplexNode*& s, ComplexNode*& e)
{
    std::string a1, a2, a3, a4, a5, a6;
    a1=s->getCode();
    a2=e->getCode();
    code="["+a1+" "+a2+"] 0 setdash";

    return this;
}

ComplexNode* ComplexNode::arc(ComplexNode*& p, ComplexNode*& r, ComplexNode*& alpha, ComplexNode*& beta)
{
    std::string a1, a2, a3, a4, a5, a6;
    std::string xy;
    xy=p->getCode();

    a3=r->getCode();
    a4=alpha->getCode();
    a5=beta->getCode();
    code="newpath "+xy+" "+a3+" "+a4+" "+a5+" arc";

    return this;
}

ComplexNode* ComplexNode::ellipse(ComplexNode*& p, ComplexNode*& r1, ComplexNode*& r2, ComplexNode*& alpha, ComplexNode*& beta)
{
    std::string a1, a2, a3, a4, a5, a6;
    std::string xy;
    xy=p->getCode();

    a3=r1->getCode();
    a4=r2->getCode();
    a5=alpha->getCode();
    a6=beta->getCode();
    code="newpath /savematrix matrix currentmatrix def "+xy+" translate "+a3+" "+a4+" scale 0 0 1 "+a5+" "+a6+" arc savematrix setmatrix"; //TODO: have to undo the translate here

    return this;
}

ComplexNode* ComplexNode::string2path(ComplexNode*& p, ComplexNode*& s)
{
    std::string a1, a2, a3, a4, a5, a6;
    std::string xy;
    s->checkType(Type::STRING);
    xy=p->getCode();
    a3=s->getCode();

    code="newpath "+xy+" moveto "+a3+" true charpath";
    //std::cout<<"Code written: "<<code<<std::endl;

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
    std::string a1, a2, a3, a4, a5, a6;
    a1=n->getCode();

    code=a1+" 20 string cvs";
    
    setType(Type::STRING);

    return this;
}

ComplexNode* ComplexNode::draw(ComplexNode*& p)
{
    std::string a1, a2, a3, a4, a5, a6;
    p->checkType(Type::PATH);
    
    a1=p->getCode();
    //std::cout<<"test: "<<a1<<std::endl;
    code=a1+" stroke";

    return this;
}

ComplexNode* ComplexNode::fill(ComplexNode*& p)
{
    std::string a1, a2, a3, a4, a5, a6;
    p->checkType(Type::PATH);
    
    a1=p->getCode();
    code=a1+" closepath fill";

    return this;
}
ComplexNode* ComplexNode::bind_valins(ComplexNode*& lhs, ComplexNode*& rhs)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    a1=lhs->getCode();
    a2=rhs->getCode();

    code="/"+a1+" "+a2+" def";

    return this;
}

ComplexNode* ComplexNode::bind_ident_early(ComplexNode*& lhs, ComplexNode*& rhs)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    a1=lhs->getCode();
    a2=rhs->getCode();

    code="/"+a1+" //"+a2+" def";

    return this;
}

ComplexNode* ComplexNode::bind_ident_late(ComplexNode*& lhs, ComplexNode*& rhs)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    a1=lhs->getCode();
    a2=rhs->getCode();

    code="/"+a1+" {"+a2+"} def";

    return this;
}

ComplexNode* ComplexNode::latebinding(ComplexNode*& lhs, ComplexNode*& rhs)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    a1=lhs->getCode();
    a2=rhs->getCode();


    //std::cout<<"a1 is: "<<a1<<std::endl;
    //std::cout<<"a2 is: "<<a2<<std::endl;
    code="/"+a1+" { "+a2+" } def";

    return this;
}

ComplexNode* ComplexNode::earlybinding(ComplexNode*& lhs, ComplexNode*& rhs)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    a1=lhs->getCode();
    a2=rhs->getCode();


    //std::cout<<"a1 is: "<<a1<<std::endl;
    //std::cout<<"a2 is: "<<a2<<std::endl;
    code="/"+a1+" { "+a2+" } bind def";

    return this;
}

ComplexNode* ComplexNode::binop(ComplexNode*& left, ComplexNode*& right, std::string op)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
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
    a1=left->getCode();

    code=a1+" "+op;

    return this;
}

ComplexNode* ComplexNode::forloop(ComplexNode*& id, ComplexNode*& start, ComplexNode*& end, ComplexNode*& inc, ComplexNode*& cmd)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
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

ComplexNode* ComplexNode::translate(ComplexNode*& x, ComplexNode*& y, ComplexNode*& therma)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    a1=x->getCode();
    a2=y->getCode();
    a3=therma->getCode();

    code=a1+" "+a2+" translate "+a3+" "+a1+" neg "+a2+" neg translate" ;

    return this;
}

ComplexNode* ComplexNode::rotate(ComplexNode*& alpha, ComplexNode*& therma)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    a1=alpha->getCode();
    a2=therma->getCode();

    code=a1+"  rotate "+a2+" "+a1+" neg rotate";

    return this;
}

ComplexNode* ComplexNode::scale(ComplexNode*& x, ComplexNode*& y, ComplexNode*& therma)
{
    std::string a1,dummy, a2, a3, a4, a5, a6;
    a1=x->getCode();
    a2=y->getCode();
    a3=therma->getCode();

    code=a1+" "+a2+" scale "+a3+" 1 "+a1+" div 1 "+a2+" div scale" ;

    return this;
}

ComplexNode* ComplexNode::clip(ComplexNode*& p, ComplexNode*& t)
{
    std::string cliparea, term;
    cliparea=p->getCode();
    term=t->getCode();
    code="clipsave\n"+cliparea+"\nclip\n"+term+"\ncliprestore";

    return this;
}


std::string typeToString(Type type){
	switch(type){
		case Type::INT: return "int";
		case Type::NUM: return "num";
		case Type::STRING: return "string";
		case Type::POINT: return "point";
		case Type::PATH: return "path";
		case Type::TERM: return "term";
		default: std::cout<<"type to string error\n. Program quits"<<std::endl;exit(-1);
		}
	}
