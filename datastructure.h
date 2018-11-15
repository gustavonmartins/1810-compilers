#include <iostream>
#include <vector>


class PotentialValue {
	std::string								_string;
	int 											_int;
	double 										_double,_r,_alpha,_beta;
	std::pair<double,double> 	_point;
	
	public:
	PotentialValue* setString(const std::string i_string){_string=i_string;	return this;}
	PotentialValue* setInt(const int i_int){_int=i_int;									return this;}
	PotentialValue* setDouble(const double i_double){_double=i_double;			return this;}
	PotentialValue* setPoint(double x, double y){_point.first=x;_point.second=y; return this;}
	
	double getDouble()									{return _double;}
	int getInt()												{return _int;}
	std::string getString()							{return _string;}
	std::pair<double,double> getPoint()	{return _point;}

	//void eval() {}
};

class FCall  {
	public:
	void setcolor(PotentialValue* r,PotentialValue* g,PotentialValue* b){
		double _r, _g, _b;
		  _r=r->getDouble();
		  _g=g->getDouble();
		  _b=b->getDouble();
		  std::cout<<_r<<" "<<_g<<" "<<_b<<" setrgbcolor\n\n";
		}
		void setfont(PotentialValue* font,PotentialValue* s){
			std::string _font;
			int _s;
			_font=font->getString();
			_s = s->getInt();
			std::cout<<"/"<<_font<<"\n"<<_s<<" scalefont\n\n";
			}
			
		void setlinewidth(PotentialValue* w){
			  int _w;
			  _w=w->getInt();
			  std::cout<<_w<<" setlinewidth\n\n";
			}
		
		void setdrawstyle(PotentialValue* s, PotentialValue* e){
			  int _s, _e;
			  _s=s->getInt();
			  _e=e->getInt();
			  std::cout<<"["<<_s<<" "<<_e<<"] 0 setdash""\n\n";
			}
		void arc(PotentialValue* point, PotentialValue* r, PotentialValue* alpha, PotentialValue* beta){
			std::pair<double,double> _point=point->getPoint();
			double _r, _alpha, _beta;
			_r=r->getDouble();
			_alpha=alpha->getDouble();
			_beta=beta->getDouble();
			std::cout<<_point.first<<" "<<_point.second<<" "<<_r<<" "<<_alpha<<" "<<_beta<<" arc closepath \nstroke\n\n";}
};
