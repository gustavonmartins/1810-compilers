#include <iostream>
#include <vector>

class PotentialValue {
	std::string								_code;
	std::pair<std::string,std::string> 	_point;
	
	public:
	PotentialValue()=default;
	PotentialValue(char* code){_code.assign(code);}
	PotentialValue* setPoint(std::string x, std::string y){_point.first=x;_point.second=y; return this;}
	std::pair<std::string,std::string> getPoint()	{return _point;}
	std::string getCode()								{return _code;}
};

class FCall  {
	std::string code;
	
	public:
	void printCode(){std::cout<<code<<std::endl;}
	void setcolor(PotentialValue* r,PotentialValue* g,PotentialValue* b){
		std::string a1, a2, a3, a4, a5, a6;
		a1=r->getCode();
		a2=g->getCode();
		a3=b->getCode();
		code=a1+" "+a2+" "+a3+" setrgbcolor";
		}
		void setfont(PotentialValue* font,PotentialValue* s){
			std::string a1, a2, a3, a4, a5, a6;
			a1=font->getCode();
			a2 = s->getCode();
			code="/"+a1+" findfont "+a2+" scalefont setfont";
			}
			
		void setlinewidth(PotentialValue* w){
			std::string a1, a2, a3, a4, a5, a6;
			  a1=w->getCode();
			  code=a1+" setlinewidth";
			}
		
		void setdrawstyle(PotentialValue* s, PotentialValue* e){
			std::string a1, a2, a3, a4, a5, a6;
			  a1=s->getCode();
			  a2=e->getCode();
			  code="["+a1+" "+a2+"] 0 setdash";
			}
			
		void arc(PotentialValue* p, PotentialValue* r, PotentialValue* alpha, PotentialValue* beta){
			std::string a1, a2, a3, a4, a5, a6;
			a1=p->getPoint().first;
			a2=p->getPoint().second;
			a3=r->getCode();
			a4=alpha->getCode();
			a5=beta->getCode();
			code="newpath "+a1+" "+a2+" "+a3+" "+a4+" "+a5+" arc";
			}
			
		void ellipse(PotentialValue* p, PotentialValue* r1, PotentialValue* r2, PotentialValue* alpha, PotentialValue* beta){
			std::string a1, a2, a3, a4, a5, a6;
			a1=p->getPoint().first;
			a2=p->getPoint().second;
			a3=r1->getCode();
			a4=r2->getCode();
			a5=alpha->getCode();
			a6=beta->getCode();
			code="newpath /savematrix matrix currentmatrix def "+a1+" "+a2+" translate "+a3+" "+a4+" scale 0 0 1 "+a5+" "+a6+" arc savematrix setmatrix";
			}
		
		void string2path(PotentialValue* p, PotentialValue* s){
			std::string a1, a2, a3, a4, a5, a6;
			a1=p->getPoint().first;
			a2=p->getPoint().second;
			a3=s->getCode();
			
			code="newpath "+a1+" "+a2+" moveto ("+a3+") true charpath";
			//std::cout<<"Code written: "<<code<<std::endl;
			
			}
		
		void draw(PotentialValue* p){
			std::string a1, a2, a3, a4, a5, a6;
			a1=p->getCode();
			//std::cout<<"test: "<<a1<<std::endl;
			code=a1+" stroke";
			}
		
		void fill(PotentialValue* p){
			std::string a1, a2, a3, a4, a5, a6;
			a1=p->getCode();
			code=a1+" closepath fill";
			}
};
