#include <iostream>
#include "registers.h"

using namespace std;

Registers::Registers ()
{
	for(int i = 0; i<32; i++)
	{
		this->setRegister(i,0);
	}
}

Registers::setRegister(int regNum, int value)
{
	if(regNum>0 and regNum<32)
	{

	}
	else
	{
		throw std::invalid_argument("");
	}
}


std::ostream& operator<<(std::ostream& out, const Registers& reg)
{
	out<<"ProgramCounter:" << reg.getPC() << "\n";
	for(int i = 0; i<32; i++)
	{
		out<<"reg" << i << reg.getRegister(i) << "\n";
	}
    return out;
}
