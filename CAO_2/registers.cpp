#include <iostream>
#include "registers.h"

using namespace std;


Registers::Registers ()
{
	for(int i = 0; i<32; i++)
	{
		this->setRegister(i,0);
	}
	program_counter = 0;
}

void Registers::setRegister(int regNum, int value)
{
	if(regNum>=0 and regNum<32)
	{
	    this->reg[regNum] = value;
	}
	else
	{
		throw std::invalid_argument("");
	}
}

int Registers::getRegister(int regNum)
{
    if(regNum>=0 and regNum<32)
    {
        if (regNum == 0) {
            return 0;
        }
        else {
            return this->reg[regNum];
        }
    }
    else
    {
        throw std::invalid_argument("");
    }
}

void Registers::setPC(int value)
{
    this->program_counter = value;
}

int Registers::getPC()
{
    return this->program_counter;
}

void Registers::print()
{
    std::cout<<"ProgramCounter: " << this->getPC() << "\n";
    for(int i = 0; i<32; i++)
    {
        std::cout<<"$" << i << "\t: " << this->getRegister(i) << "\n";
    }
}
