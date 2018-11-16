#include <iostream>
#include <vector>

class PotentialValue {
	std::string								_code;
	std::string								_string;
	int 											_int;
	double 										_double,_r,_alpha,_beta;
	std::pair<std::string,std::string> 	_point;
	
	public:
	PotentialValue* setString(const std::string i_string){_string=i_string;	return this;}
	PotentialValue* setInt(const int i_int){_int=i_int;									return this;}
	PotentialValue* setDouble(const double i_double){_double=i_double;			return this;}
	PotentialValue* setPoint(std::string x, std::string y){_point.first=x;_point.second=y; return this;}
	PotentialValue* setCode(std::string code){_code=code;return this;}
	
	double getDouble()									{return _double;}
	int getInt()												{return _int;}
	std::string getString()							{return _string;}
	std::pair<std::string,std::string> getPoint()	{return _point;}
	std::string getCode()								{return _code;}

	//void eval() {}
};

class FCall  {
	std::string a1, a2, a3, a4, a5, a6;
	public:
	void setcolor(PotentialValue* r,PotentialValue* g,PotentialValue* b){
		  a1=r->getCode();
		  a2=g->getCode();
		  a3=b->getCode();
		  std::cout<<a1<<" "<<a2<<" "<<a3<<" setrgbcolor\n\n";
		}
		void setfont(PotentialValue* font,PotentialValue* s){
			int _s;
			a1=font->getCode();
			a2 = s->getCode();
			std::cout<<"/"<<a1<<" findfont \n"<<a2<<" scalefont \nsetfont\n\n";
			}
			
		void setlinewidth(PotentialValue* w){
			  a1=w->getCode();
			  std::cout<<a1<<" setlinewidth\n\n";
			}
		
		void setdrawstyle(PotentialValue* s, PotentialValue* e){
			  a1=s->getCode();
			  a2=e->getCode();
			  std::cout<<"["<<a1<<" "<<a2<<"] 0 setdash""\n\n";
			}
			
		void arc(PotentialValue* p, PotentialValue* r, PotentialValue* alpha, PotentialValue* beta){
			a1=p->getPoint().first;
			a2=p->getPoint().second;
			a3=r->getCode();
			a4=alpha->getCode();
			a5=beta->getCode();
			std::cout<<"newpath "<<a1<<" "<<a2<<" "<<a3<<" "<<a4<<" "<<a5<<" arc stroke\n\n";
			}
			
		void ellipse(PotentialValue* p, PotentialValue* r1, PotentialValue* r2, PotentialValue* alpha, PotentialValue* beta){
			std::cout<<"1 "<<r2->getCode()<<" "<<r1->getCode()<<" div scale \n";
			a1=p->getPoint().first;
			a2=p->getPoint().second;
			a3=r1->getCode();
			a4=alpha->getCode();
			a5=beta->getCode();
			std::cout<<"newpath "<<a1<<" "<<a2<<" "<<a3<<" "<<a4<<" "<<a5<<" arc stroke\n\n";
			}
		
		void string2path(PotentialValue* p, PotentialValue* s){
			a1=p->getPoint().first;
			a2=p->getPoint().second;
			a3=s->getCode();
			
			std::cout<<"newpath "<<a1<<" "<<a2<<" moveto ("<<a3<<") true charpath stroke\n\n";
			}
};
