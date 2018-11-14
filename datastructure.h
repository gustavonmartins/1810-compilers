#include <iostream>
class ComplexNode {
		
  public:
  virtual ComplexNode*  eval()=0;
};

struct Value : public ComplexNode {
	public:
	std::string val_string;
  double val_num;
  int val_int;

	ComplexNode* eval(){}
};
